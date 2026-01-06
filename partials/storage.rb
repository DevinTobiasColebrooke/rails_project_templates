def setup_active_storage
  puts "📦  Configuring Active Storage..."

  # 1. Install migrations and configuration
  run "bin/rails active_storage:install"

  # 2. Update storage.yml for S3 (Credentials based)
  # We append this to the existing generated file to ensure the structure is correct
  append_to_file "config/storage.yml" do
    <<~YAML

      # AWS S3 (Production)
      # Requires aws-sdk-s3 gem
      amazon:
        service: S3
        access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
        secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
        region: "us-east-1"
        bucket: "your-app-production"
    YAML
  end

  # 3. Configure Production to use Amazon by default
  # (Commented out so it doesn't break until credentials are set, but ready to go)
  gsub_file "config/environments/production.rb", 
            /config.active_storage.service = :local/, 
            "# config.active_storage.service = :amazon # Switch to :amazon when credentials are ready"

end