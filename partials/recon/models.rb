def setup_recon_models
  # We use generate model to create the files, but we'll overwrite the content to match the specific schema
  generate :model, "ReconnaissanceLog query:string domain:string location:string report:text method:string logs:jsonb"
  
  # WebDocument needs vector support
  generate :model, "WebDocument url:string:index content:text"
  
  # Update WebDocument migration to add vector column and index
  migration_file = Dir.glob("db/migrate/*_create_web_documents.rb").first
  if migration_file
    inject_into_file migration_file, after: "t.text :content\n" do
      "      t.vector :embedding, limit: 768\n"
    end
    inject_into_file migration_file, after: "t.timestamps\n    end\n" do
      <<-RUBY
    add_index :web_documents, :url, unique: true
    # HNSW Index for fast similarity search
    add_index :web_documents, :embedding, using: :hnsw, opclass: :vector_l2_ops
      RUBY
    end
  end

  # Model Logic
  create_file "app/models/web_document.rb", <<~RUBY, force: true
    class WebDocument < ApplicationRecord
      has_neighbors :embedding
      validates :url, presence: true, uniqueness: true
    end
  RUBY

  create_file "app/models/reconnaissance_log.rb", <<~RUBY, force: true
    class ReconnaissanceLog < ApplicationRecord
      validates :query, presence: true
    end
  RUBY
end