def setup_recon_tools
  create_file "app/services/tools/base_tool.rb", <<~RUBY
    module Tools
      class BaseTool
        def self.definition
          {
            type: "function",
            function: {
              name: tool_name,
              description: description,
              parameters: {
                type: :object,
                properties: parameters,
                required: required_parameters
              }
            }
          }
        end

        def self.tool_name; raise NotImplementedError; end
        def self.description; raise NotImplementedError; end
        def self.parameters; raise NotImplementedError; end
        def self.required_parameters; []; end

        def call(args); raise NotImplementedError; end
      end
    end
  RUBY

  create_file "app/services/tools/google_search_tool.rb", <<~RUBY
    module Tools
      class GoogleSearchTool < BaseTool
        def self.tool_name
          "google_search"
        end

        def self.description
          "Search Google for specific, high-confidence public information like official websites, news, or reports."
        end

        def self.parameters
          {
            query: { type: :string, description: "The search keywords." }
          }
        end

        def self.required_parameters
          [ "query" ]
        end

        def call(args)
          query = args["query"]
          results = GoogleCustomSearchService.search(query)

          if results && results["results"].any?
            results["results"].first(5).map do |item|
              "Title: \#{item['title']}\\nLink: \#{item['url']}\\nSnippet: \#{item['snippet']}"
            end.join("\\n---\\n")
          else
            "No results found on Google."
          end
        rescue => e
          "Google Search Error: \#{e.message}"
        end
      end
    end
  RUBY

  create_file "app/services/tools/searxng_search_tool.rb", <<~RUBY
    module Tools
      class SearxngSearchTool < BaseTool
        def self.tool_name
          "searxng_search"
        end

        def self.description
          "Search the web using SearXNG. Use this for broad queries, finding documents/PDFs, or when Google is too restrictive."
        end

        def self.parameters
          {
            query: { type: :string, description: "The search query" }
          }
        end

        def self.required_parameters
          [ "query" ]
        end

        def call(args)
          query = args["query"]
          results = WebSearchService.search(query)

          if results && results["results"].any?
            results["results"].first(5).map do |r|
              "Title: \#{r['title']}\\nURL: \#{r['url']}\\nSnippet: \#{r['content']}"
            end.join("\\n---\\n")
          else
            "No results found on SearXNG."
          end
        rescue => e
          "SearXNG Error: \#{e.message}"
        end
      end
    end
  RUBY

  create_file "app/services/tools/visit_page_tool.rb", <<~RUBY
    module Tools
      class VisitPageTool < BaseTool
        def self.tool_name
          "visit_page"
        end

        def self.description
          "Visit a specific URL and extract its text content. Use this to read a page found in search results to get detailed information."
        end

        def self.parameters
          {
            url: { type: :string, description: "The URL to visit." }
          }
        end

        def self.required_parameters
          [ "url" ]
        end

        def call(args)
          url = args["url"]
          browser = Ferrum::Browser.new(timeout: 20, headless: true, process_timeout: 30)

          begin
            content = WebSearchService.fetch_page_content(url, browser: browser)
            if content.present?
              "Page Content for \#{url}:\\n\#{content.slice(0, 4000)}..." # Limit tokens
            else
              "Visited \#{url} but found no readable text."
            end
          rescue => e
            "Error visiting page: \#{e.message}"
          ensure
            browser.quit
          end
        end
      end
    end
  RUBY
end