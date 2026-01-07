def setup_api_client_base
  create_file "app/models/api_client_base.rb", <<~RUBY
    require "faraday"
    require "json"

    class ApiClientBase
      include ActiveModel::Model

      attr_reader :base_url, :api_key

      def initialize(base_url:, api_key: nil)
        @base_url = base_url
        @api_key = api_key
      end

      protected

      def connection
        @connection ||= Faraday.new(url: @base_url) do |conn|
          conn.request :json
          conn.response :json, content_type: /\bjson$/
          conn.adapter Faraday.default_adapter
        end
      end

      def get(endpoint, params = {})
        response = connection.get(endpoint, params)
        response.success? ? response.body : nil
      rescue Faraday::Error
        nil
      end
    end
  RUBY
end