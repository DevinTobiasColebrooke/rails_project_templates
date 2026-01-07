def setup_rag_engine
  create_file "app/models/rag_engine.rb", <<~RUBY
    require "parallel"

    class RagEngine
      def initialize(query, providers:, context: nil)
        @query = query
        @providers = providers
        @context = context
      end

      def search_and_synthesize
        all_results = Parallel.map(@providers) { |p| p.search(@query) rescue nil }
        urls = all_results.compact.flat_map { |r| r["results"] }.uniq { |r| r["url"] }.first(10).map { |r| r["url"] }
        return [nil, []] if urls.empty?

        buffer = ""
        browser = Ferrum::Browser.new(timeout: 20, headless: true)
        
        begin
          urls.each do |url|
            content = fetch_content(url, browser)
            if content.present?
              save_vector(url, content)
              buffer += "Source: \#{url}\\nContent: \#{content.slice(0, 1500)}\\n\\n"
            end
          end
        ensure
          browser.quit
        end

        [buffer, urls]
      end

      private

      def fetch_content(url, browser)
        return @context.get_page(url) if @context && @context.get_page(url)
        
        text = WebSearcher.fetch_page_content(url, browser: browser)
        @context.cache_page(url, text) if @context && text
        text
      end

      def save_vector(url, content)
        return if WebDocument.exists?(url: url)
        embedding = EmbeddingGenerator.generate(content.slice(0, 2000))
        WebDocument.create!(url: url, content: content, embedding: embedding) if embedding
      rescue
        nil
      end
    end
  RUBY
end