def setup_active_storage
  puts "📦  Configuring Active Storage..."

  # 1. Install migrations and configuration
  run "bin/rails active_storage:install"
end