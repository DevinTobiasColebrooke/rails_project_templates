# partials/vector_db.rb

def setup_vector_db
  puts "🧮  Configuring Vector Database (pgvector)..."

  # 1. Enable Database Extension
  generate :migration, "EnableVectorExtension"
  migration_file = Dir.glob("db/migrate/*_enable_vector_extension.rb").first
  if migration_file
    inject_into_file migration_file, after: "def change\n" do
      "    enable_extension 'vector'\n"
    end
  end

  # 2. Create Documents Table
  # We use a generic schema. You can associate this with Users or Projects later.
  # 768 dimensions is standard for Nomic/BERT/Llama embeddings.
  generate :model, "Document content:text embedding:vector{768} metadata:jsonb"
  
  # 3. Configure Model (Neighbor)
  inject_into_file "app/models/document.rb", after: "class Document < ApplicationRecord\n" do
    <<~RUBY
      has_neighbors :embedding
      
      # Simple wrapper to find similar content
      def self.semantic_search(query, limit: 5)
        # 1. Generate embedding for the query
        query_vector = EmbeddingService.generate(query)
        return [] unless query_vector

        # 2. Search by nearest neighbor (Cosine Similarity)
        nearest_neighbors(:embedding, query_vector, distance: "cosine").limit(limit)
      end
    RUBY
  end

  # 4. Create Embedding Service
  # This serves as the bridge between your DB and your AI Provider
  create_file "app/services/embedding_service.rb", <<~RUBY
    class EmbeddingService
      def self.generate(text)
        if defined?(AiConfig::LOCAL_EMBEDDING_URL)
          generate_local(text)
        elsif defined?(AiConfig::GEMINI_API_KEY)
          # Placeholder: Gemini requires specific embedding models
          Rails.logger.warn "Gemini Embeddings not configured yet."
          nil
        else
          Rails.logger.warn "No Embedding provider configured."
          nil
        end
      end

      private

      def self.generate_local(text)
        require 'net/http'
        uri = URI("\#{AiConfig::LOCAL_EMBEDDING_URL}/embeddings")
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
        request.body = { content: text }.to_json
        
        response = http.request(request)
        return nil unless response.is_a?(Net::HTTPSuccess)
        
        json = JSON.parse(response.body)
        # Handle various response formats from llama-server
        (json["embedding"] || json.dig("data", 0, "embedding"))&.flatten&.map(&:to_f)
      rescue => e
        Rails.logger.error "Local Embedding Error: \#{e.message}"
        nil
      end
    end
  RUBY
end