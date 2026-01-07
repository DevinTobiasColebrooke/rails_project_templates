def setup_web_searcher
  create_file "app/models/web_searcher.rb", <<~RUBY, force: true
    require "ferrum"
    require "net/http"

    class WebSearcher
      SEARX_INSTANCE_URL = ENV.fetch("SEARXNG_URL", "http://localhost:8888").freeze

      def self.search(query)
        uri = URI("\#{SEARX_INSTANCE_URL}/search")
        uri.query = URI.encode_www_form({ q: query, format: "json", categories: "general", language: "en" })
        response = Net::HTTP.get_response(uri)
        return JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
        nil
      rescue
        nil
      end

      def self.fetch_page_content(url, browser: nil)
        should_close = browser.nil?
        browser ||= Ferrum::Browser.new(timeout: 20, headless: true, process_timeout: 30)

        begin
          browser.go_to(url)
          browser.network.wait_for_idle(duration: 2)
          browser.execute("document.querySelectorAll('script, style, nav, footer, svg').forEach(el => el.remove());")
          text = browser.evaluate("document.body.innerText")
          return "" unless text.is_a?(String)
          text.gsub(/(\\n\\s*){3,}/, "\\n\\n").strip
        rescue
          nil
        ensure
          browser.quit if should_close
        end
      end
    end
  RUBY
end