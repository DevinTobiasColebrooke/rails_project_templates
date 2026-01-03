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
  gem 'bullet'
  gem 'prosopite'
end

gem_group :development do
  gem 'letter_opener', '~> 1.0'
  gem 'letter_opener_web', '~> 3.0'
  gem 'annotate'
end

# 2. Production Observability & Data
gem 'rack-attack'
gem 'pg_query'
gem 'scenic'
gem 'ahoy_matey'

# 3. SEO
if @install_seo
  gem 'meta-tags'
  gem 'sitemap_generator'
end

# 4. Stripe
if @install_stripe
  gem 'stripe', '~> 10.0'
end

# 5. Vector Database
if @install_vector_db
  gem "pgvector", "~> 0.2"
  gem "neighbor"
  gem "parallel"
end

# 6. AI Services
if @install_gemini || @install_local
  gem "faraday", "~> 2.14"
  gem "json"
  gem "ruby-openai", "~> 6.0"
end