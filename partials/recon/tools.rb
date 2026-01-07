def setup_recon_tools
  # Tools are now Strategies under app/models/tools/
  
  create_file "app/models/tools/base.rb", <<~RUBY
    module Tools
      class Base
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
        def run(args); raise NotImplementedError; end
      end
    end
  RUBY

  create_file "app/models/tools/google_search.rb", <<~RUBY
    module Tools
      class GoogleSearch < Base
        def self.tool_name; "google_search"; end
        def self.description; "Search Google for official info."; end
        def self.parameters; { query: { type: :string } }; end
        def self.required_parameters; ["query"]; end

        def run(args)
          results = GoogleSearcher.search(args["query"])
          if results && results["results"].any?
            results["results"].first(5).map { |i| "Title: \#{i['title']}\\nLink: \#{i['url']}\\nSnippet: \#{i['snippet']}" }.join("\\n---\\n")
          else
            "No results found."
          end
        end
      end
    end
  RUBY

  create_file "app/models/tools/searxng_search.rb", <<~RUBY
    module Tools
      class SearxngSearch < Base
        def self.tool_name; "searxng_search"; end
        def self.description; "Broad search via SearXNG."; end
        def self.parameters; { query: { type: :string } }; end
        def self.required_parameters; ["query"]; end

        def run(args)
          results = WebSearcher.search(args["query"])
          if results && results["results"].any?
            results["results"].first(5).map { |r| "Title: \#{r['title']}\\nURL: \#{r['url']}\\nSnippet: \#{r['content']}" }.join("\\n---\\n")
          else
            "No results found."
          end
        end
      end
    end
  RUBY

  create_file "app/models/tools/visit_page.rb", <<~RUBY
    module Tools
      class VisitPage < Base
        def self.tool_name; "visit_page"; end
        def self.description; "Visit and read a URL."; end
        def self.parameters; { url: { type: :string } }; end
        def self.required_parameters; ["url"]; end

        def run(args)
          content = WebSearcher.fetch_page_content(args["url"])
          content.present? ? "Page Content:\\n\#{content.slice(0, 4000)}..." : "No readable text."
        end
      end
    end
  RUBY
end