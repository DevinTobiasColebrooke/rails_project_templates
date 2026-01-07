def setup_vector_db_database
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
  generate :model, "Document content:text embedding:vector{768} metadata:jsonb"
end