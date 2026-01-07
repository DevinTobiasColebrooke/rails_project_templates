def setup_vector_embeddable
  create_file "app/models/concerns/vector_embeddable.rb", <<~RUBY
    module VectorEmbeddable
      extend ActiveSupport::Concern

      class_methods do
        def generate_embedding(text)
          # Check if the AI Config exists and has a local embedding URL
          if defined?(AiConfig::LOCAL_EMBEDDING_URL)
            fetch_embedding_from_api(text)
          else
            Rails.logger.warn "No Embedding provider configured."
            nil
          end
        end

        private

        def fetch_embedding_from_api(text)
          require 'net/http'
          uri = URI("\#{AiConfig::LOCAL_EMBEDDING_URL}/embeddings")
          http = Net::HTTP.new(uri.host, uri.port)
          
          request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
          request.body = { content: text }.to_json
          
          response = http.request(request)
          return nil unless response.is_a?(Net::HTTPSuccess)
          
          json = JSON.parse(response.body)
          (json["embedding"] || json.dig("data", 0, "embedding"))&.flatten&.map(&:to_f)
        rescue => e
          Rails.logger.error "Embedding Error: \#{e.message}"
          nil
        end
      end
    end
  RUBY
end