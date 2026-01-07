def setup_document_ingestable
  create_file "app/models/concerns/document_ingestable.rb", <<~RUBY
    require 'pdf-reader'

    module DocumentIngestable
      extend ActiveSupport::Concern

      class_methods do
        def ingest(file_path, metadata: {})
          return unless File.exist?(file_path)

          text_content = extract_text_from_file(file_path)
          return if text_content.blank?

          # Chunking strategy
          chunks = text_content.split(/\\n\\n+/).reject(&:blank?)
          
          puts "   -> Processing \#{chunks.size} chunks from \#{File.basename(file_path)}..."

          chunks.each_with_index do |chunk, index|
            next if chunk.length < 50 

            # Uses method from VectorEmbeddable
            vector = generate_embedding(chunk)
            
            if vector
              create!(
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

        private

        def extract_text_from_file(path)
          ext = File.extname(path).downcase
          case ext
          when '.pdf'
            PDF::Reader.new(path).pages.map(&:text).join("\\n\\n")
          when '.txt', '.md', '.csv', '.json'
            File.read(path)
          else
            Rails.logger.warn "Unsupported file type: \#{ext}"
            nil
          end
        rescue => e
          Rails.logger.error "Extraction Failed: \#{e.message}"
          nil
        end
      end
    end
  RUBY
end