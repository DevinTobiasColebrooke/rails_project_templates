def setup_vector_db_model
  # 4. Update Document Model to include Concerns
  inject_into_file "app/models/document.rb", after: "class Document < ApplicationRecord\n" do
    <<~RUBY
      include VectorEmbeddable
      include DocumentIngestable

      has_neighbors :embedding
      
      def self.semantic_search(query, limit: 5)
        query_vector = generate_embedding(query)
        return [] unless query_vector

        nearest_neighbors(:embedding, query_vector, distance: "cosine").limit(limit)
      end
    RUBY
  end
end