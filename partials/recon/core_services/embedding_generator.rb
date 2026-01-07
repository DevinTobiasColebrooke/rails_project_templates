def setup_embedding_generator
  create_file "app/models/embedding_generator.rb", <<~RUBY, force: true
    class EmbeddingGenerator
      EMBEDDING_BASE_URL = ENV.fetch("LLM_EMBEDDING_URL", AiConfig::LOCAL_EMBEDDING_URL).freeze

      def self.generate(text)
        return nil if text.blank?
        client = OpenAI::Client.new(
          access_token: LlmClient::API_KEY,
          uri_base: EMBEDDING_BASE_URL,
          request_timeout: 30
        )
        response = client.embeddings(
          parameters: {
            model: "nomic-embed-text-v1.5.f32.gguf",
            input: text.slice(0, 8000)
          }
        )
        response.dig("data", 0, "embedding")
      rescue => e
        Rails.logger.error "Embedding Error: \#{e.message}"
        nil
      end
    end
  RUBY
end