# partials/gems.rb
puts "\n📦  Defining Gems..."

# 1. Standard Dev/Test
gem_group :development, :test do
  gem 'rspec-rails', '~> 7.0'
  gem 'factory_bot_rails', '~> 6.0'
  gem 'guard', '~> 2.19'
  gem 'guard-rspec', '~> 4.7'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  
  # Performance & Observability (Dev)
  gem 'bullet'         # Detect N+1 queries
  gem 'prosopite'      # N+1 auto-detection (alternative to bullet)
end

gem_group :development do
  gem 'letter_opener', '~> 1.0'
  gem 'letter_opener_web', '~> 3.0'
  gem 'annotate'       # Adds schema comments to models
end

# 2. Production Observability & Data
gem 'rack-attack'      # Rate limiting & protection
gem 'pg_query'         # SQL query parsing
gem 'scenic'           # Database Views support
gem 'ahoy_matey'       # First-party analytics
gem 'blazer'           # (Optional) Business Intelligence/SQL queries

# 3. SEO
gem 'meta-tags'
gem 'sitemap_generator'

# 4. Stripe
if @install_stripe
  gem 'stripe', '~> 10.0'
end

# 5. AI
if @install_gemini || @install_local || @install_rag
  gem "faraday", "~> 2.14"
  gem "json"
end

if @install_gemini || @install_local
  gem "ruby-openai", "~> 6.0"
end

if @install_rag
  gem "ferrum"
  gem "ruby-readability", require: "readability"
  gem "nokogiri", "~> 1.18"
  gem "pgvector", "~> 0.2"
  gem "neighbor"
  gem "parallel"
end