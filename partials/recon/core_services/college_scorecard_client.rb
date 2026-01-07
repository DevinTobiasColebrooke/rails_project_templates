def setup_college_scorecard_client
  create_file "app/models/college_scorecard_client.rb", <<~RUBY
    class CollegeScorecardClient < ApiClientBase
      BASE_URL = "https://api.data.gov/ed/collegescorecard/v1".freeze

      def initialize
        super(
          base_url: BASE_URL,
          api_key: Rails.application.credentials.data_gov_key || ENV['DATA_GOV_KEY']
        )
      end

      def search_schools(query)
        return nil if @api_key.blank?
        get("schools", {
          api_key: @api_key,
          "school.name" => query,
          fields: "id,school.name,school.school_url,school.city,school.state,latest.student.size",
          per_page: 5
        })
      end
    end
  RUBY
end