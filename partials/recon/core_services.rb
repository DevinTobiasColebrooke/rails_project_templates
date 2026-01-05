def setup_recon_core_services
  # 1. Embedding Service
  create_file "app/services/embedding_service.rb", <<~RUBY, force: true
    class EmbeddingService
      # Allow a specific URL for the embedding server, or fall back to the main LLM URL
      EMBEDDING_BASE_URL = ENV.fetch("LLM_EMBEDDING_URL", LocalLlmClient::BASE_URL).freeze

      def generate(text)
        return nil if text.blank?

        # Initialize client specifically for the embedding server
        client = OpenAI::Client.new(
          access_token: LocalLlmClient::API_KEY,
          uri_base: EMBEDDING_BASE_URL,
          request_timeout: 30
        )

        # Assumes Llama Server supports /v1/embeddings
        response = client.embeddings(
          parameters: {
            model: "nomic-embed-text-v1.5.f32.gguf", # Matches your batch file model
            input: text.slice(0, 8000)
          }
        )

        response.dig("data", 0, "embedding")
      rescue => e
        Rails.logger.error "EmbeddingService: Failed to generate embedding at \#{EMBEDDING_BASE_URL}: \#{e.message}"
        nil
      end
    end
  RUBY

  # 2. Web Search Service (SearXNG + Ferrum)
  create_file "app/services/web_search_service.rb", <<~RUBY, force: true
    require "ferrum"
    require "net/http"
    require "json"

    class WebSearchService
      SEARX_INSTANCE_URL = ENV.fetch("SEARXNG_URL", "http://localhost:8888").freeze

      def self.search(query)
        uri = URI("\#{SEARX_INSTANCE_URL}/search")
        params = { q: query, format: "json", categories: "general", language: "en" }
        uri.query = URI.encode_www_form(params)

        response = Net::HTTP.get_response(uri)
        return JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)

        Rails.logger.error "Search failed: \#{response.code}"
        nil
      rescue => e
        Rails.logger.error "Search exception: \#{e.message}"
        nil
      end

      def self.fetch_page_content(url, browser:)
        browser.go_to(url)
        browser.network.wait_for_idle(duration: 2)

        # Strip heavy elements to save LLM tokens
        browser.execute("document.querySelectorAll('script, style, nav, footer, svg').forEach(el => el.remove());")
        
        # Use evaluate to ensure we get the string back
        text = browser.evaluate("document.body.innerText")

        return "" unless text.is_a?(String)

        text.gsub(/(\\n\\s*){3,}/, "\\n\\n").strip
      rescue => e
        Rails.logger.warn "Failed to fetch \#{url}: \#{e.message}"
        nil
      end
    end
  RUBY

  # 3. Google Custom Search
  create_file "app/services/google_custom_search_service.rb", <<~RUBY
    require "net/http"
    require "json"
    require "uri"

    class GoogleCustomSearchService
      # Fetch from encrypted credentials
      API_KEY = Rails.application.credentials.dig(:google, :search, :api_key).freeze
      SEARCH_ENGINE_ID = Rails.application.credentials.dig(:google, :search, :search_engine_id).freeze
      BASE_URL = "https://www.googleapis.com/customsearch/v1".freeze

      def self.search(query)
        # Fail gracefully if keys are missing
        if API_KEY.blank? || SEARCH_ENGINE_ID.blank?
          Rails.logger.error "Google Custom Search credentials missing."
          return nil
        end

        uri = URI(BASE_URL)
        params = {
          key: API_KEY,
          cx: SEARCH_ENGINE_ID,
          q: query,
          num: 10
        }
        uri.query = URI.encode_www_form(params)

        response = Net::HTTP.get_response(uri)

        if response.is_a?(Net::HTTPSuccess)
          body = JSON.parse(response.body)
          items = body["items"] || []
          transformed_results = items.map do |item|
            {
              "url" => item["link"],
              "title" => item["title"],
              "snippet" => item["snippet"]
            }
          end
          { "results" => transformed_results }
        else
          Rails.logger.error "Google Custom Search failed: \#{response.code} \#{response.body}"
          nil
        end
      rescue => e
        Rails.logger.error "Google Custom Search exception: \#{e.message}"
        nil
      end

      def self.fetch_page_content(url, browser:)
        WebSearchService.fetch_page_content(url, browser: browser)
      end
    end
  RUBY

  # 4. RAG Search Service
  create_file "app/services/rag_search_service.rb", <<~RUBY
    require "parallel"

    class RagSearchService
      # The service is initialized with an array of search provider classes.
      def initialize(query, search_provider_classes:, shared_context: nil)
        @query = query
        @search_providers = search_provider_classes
        @context = shared_context
        @embedding_service = EmbeddingService.new
      end

      def search_and_synthesize
        # 1. Search Web in Parallel
        # Use Parallel.map to call the search method on each provider concurrently.
        all_results = Parallel.map(@search_providers) do |provider|
          provider.search(@query)
        rescue => e
          Rails.logger.error "Search provider \#{provider} failed: \#{e.message}"
          nil # Ensure that if a provider fails, it doesn't stop the others.
        end

        # Aggregate, deduplicate, and select top results.
        combined_results = all_results.compact.flat_map { |res| res["results"] }
        unique_urls = combined_results.uniq { |res| res["url"] }.first(10).map { |res| res["url"] }

        return [ nil, [] ] if unique_urls.empty?

        full_text_buffer = ""

        # 2. Browser setup for scraping
        browser = Ferrum::Browser.new(timeout: 20, headless: true, process_timeout: 30)

        begin
          unique_urls.each do |url|
            # Check SharedContext (Memory -> Cache -> Scrape)
            content = fetch_content_safely(url, browser)

            if content.present?
              save_to_vector_db(url, content)
              # Add to immediate context buffer (truncated)
              full_text_buffer += "Source: \#{url}\\nContent: \#{content.slice(0, 1500)}\\n\\n"
            end
          end
        ensure
          browser.quit
        end

        [ full_text_buffer, unique_urls ]
      end

      private

      def fetch_content_safely(url, browser)
        if @context
          cached = @context.get_page(url)
          return cached if cached
        end

        text = @search_providers.first.fetch_page_content(url, browser: browser)
        @context.cache_page(url, text) if @context && text
        text
      rescue => e
        Rails.logger.warn "RAG: Failed to fetch \#{url}: \#{e.message}"
        nil
      end

      def save_to_vector_db(url, content)
        # Check existence to avoid re-embedding
        return if WebDocument.exists?(url: url)

        embedding = @embedding_service.generate(content.slice(0, 2000))
        return unless embedding

        WebDocument.create!(url: url, content: content, embedding: embedding)
      rescue ActiveRecord::RecordNotUnique
        # Handled: Already exists
      rescue => e
        Rails.logger.error "RAG: Failed to save vector for \#{url}: \#{e.message}"
      end
    end
  RUBY
end