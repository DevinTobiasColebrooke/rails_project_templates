def setup_api_generator
  puts "🔌  Configuring API Service Generators..."

  # 1. Base Service
  create_file "app/services/application_api_service.rb", <<~RUBY
    class ApplicationApiService
      def initialize
        @conn = Faraday.new do |f|
          f.request :json
          f.response :json
          f.adapter Faraday.default_adapter
        end
      end

      protected

      def get(url, params = {})
        response = @conn.get(url, params)
        handle_response(response)
      end

      def handle_response(response)
        if response.success?
          response.body
        else
          Rails.logger.error "API Error: \#{response.status} - \#{response.body}"
          nil
        end
      end
    end
  RUBY

  # 2. Data.gov Example
  # Updated to use Credentials for the API key
  create_file "app/services/data_gov_service.rb", <<~RUBY
    class DataGovService < ApplicationApiService
      # https://api.data.gov/
      BASE_URL = "https://api.data.gov/ed/collegescorecard/v1"

      def initialize(api_key: nil)
        super()
        @api_key = api_key || Rails.application.credentials.data_gov_key || ENV['DATA_GOV_KEY']
      end

      def search_schools(state: 'CA')
        url = "\#{BASE_URL}/schools"
        get(url, { api_key: @api_key, 'school.state_fips': state })
      end
    end
  RUBY
  
  # 3. Add to Credentials reminder
  puts "   -> Added DataGovService. API Key configured in credentials."
end