def setup_google_searcher
  create_file "app/models/google_searcher.rb", <<~RUBY
    require "net/http"

    class GoogleSearcher
      API_KEY = Rails.application.credentials.dig(:google, :search, :api_key).freeze
      SEARCH_ENGINE_ID = Rails.application.credentials.dig(:google, :search, :search_engine_id).freeze
      BASE_URL = "https://www.googleapis.com/customsearch/v1".freeze

      def self.search(query)
        return nil if API_KEY.blank? || SEARCH_ENGINE_ID.blank?
        uri = URI(BASE_URL)
        uri.query = URI.encode_www_form({ key: API_KEY, cx: SEARCH_ENGINE_ID, q: query, num: 10 })
        
        response = Net::HTTP.get_response(uri)
        if response.is_a?(Net::HTTPSuccess)
          body = JSON.parse(response.body)
          { "results" => (body["items"] || []).map { |i| { "url" => i["link"], "title" => i["title"], "snippet" => i["snippet"] } } }
        else
          nil
        end
      rescue
        nil
      end
    end
  RUBY
end