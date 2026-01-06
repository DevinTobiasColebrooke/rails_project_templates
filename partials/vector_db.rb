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
  # We use a generic schema: 
  # - content: The text
  # - embedding: The mathematical representation (768 dimensions is standard for Nomic/Llama)
  # - metadata: JSONB for storing extra info (like source URL, author, etc)
  generate :model, "Document content:text embedding:vector{768} metadata:jsonb"
  
  # 3. Configure Model (Neighbor)
  inject_into_file "app/models/document.rb", after: "class Document < ApplicationRecord\n" do
    <<~RUBY
      has_neighbors :embedding
      
      # Simple wrapper to find similar content
      def self.semantic_search(query, limit: 5)
        # 1. Generate embedding for the query string
        query_vector = EmbeddingService.generate(query)
        return [] unless query_vector

        # 2. Search by nearest neighbor (Cosine Similarity)
        nearest_neighbors(:embedding, query_vector, distance: "cosine").limit(limit)
      end
    RUBY
  end

  # 4. Create Embedding Service
  # This serves as the bridge between your DB and your AI Provider (Windows Host)
  # SKIP if Recon is installed, as Recon provides a more advanced EmbeddingService
  unless @install_recon
    create_file "app/services/embedding_service.rb", <<~RUBY
      class EmbeddingService
        def self.generate(text)
          # Check if the AI Config exists and has a local embedding URL
          if defined?(AiConfig::LOCAL_EMBEDDING_URL)
            generate_local(text)
          else
            Rails.logger.warn "No Embedding provider configured (AiConfig::LOCAL_EMBEDDING_URL missing)."
            nil
          end
        end

        private

        def self.generate_local(text)
          require 'net/http'
          # Connects to http://192.168.x.x:8081/embeddings
          uri = URI("\#{AiConfig::LOCAL_EMBEDDING_URL}/embeddings")
          http = Net::HTTP.new(uri.host, uri.port)
          
          request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
          request.body = { content: text }.to_json
          
          response = http.request(request)
          return nil unless response.is_a?(Net::HTTPSuccess)
          
          json = JSON.parse(response.body)
          
          # Handle various response formats from different server versions
          # Standard OpenAI format vs Raw format
          (json["embedding"] || json.dig("data", 0, "embedding"))&.flatten&.map(&:to_f)
        rescue => e
          Rails.logger.error "Local Embedding Error: \#{e.message}"
          nil
        end
      end
    RUBY
  end

  # 5. Document Ingestion Service (New)
  create_file "app/services/document_ingestion_service.rb", <<~RUBY
    require 'pdf-reader'

    class DocumentIngestionService
      # Usage: DocumentIngestionService.ingest("path/to/file.pdf")
      def self.ingest(file_path, metadata: {})
        return unless File.exist?(file_path)

        # 1. Extract Content
        content = extract_content(file_path)
        return if content.blank?

        # 2. Chunking (Simple paragraph split for now)
        # Adjust delimiter based on your needs (e.g. overlap)
        chunks = content.split(/\\n\\n+/).reject(&:blank?)
        
        puts "   -> Ingesting \#{chunks.size} chunks from \#{File.basename(file_path)}..."

        chunks.each_with_index do |chunk, index|
          # Skip chunks that are too short to be meaningful
          next if chunk.length < 50 

          # 3. Generate Embedding
          vector = EmbeddingService.generate(chunk)
          
          if vector
            Document.create!(
              content: chunk,
              embedding: vector,
              metadata: metadata.merge(
                source: File.basename(file_path),
                chunk_index: index,
                total_chunks: chunks.size
              )
            )
          end
        end
      end

      def self.extract_content(path)
        ext = File.extname(path).downcase
        case ext
        when '.pdf'
          reader = PDF::Reader.new(path)
          # Join pages with double newline
          reader.pages.map(&:text).join("\\n\\n")
        when '.txt', '.md', '.csv', '.json'
          File.read(path)
        else
          Rails.logger.warn "Unsupported file type for ingestion: \#{ext}"
          nil
        end
      rescue => e
        Rails.logger.error "Ingestion Failed: \#{e.message}"
        nil
      end
    end
  RUBY
end