# partials/gems.rb
puts "\n📦  Defining Gems..."

# 1. Standard Dev/Test
gem_group :development, :test do
  gem 'rspec', '~> 3.13', '>= 3.13.2'
  gem 'factory_bot_rails', '~> 6.5', '>= 6.5.1'
  gem 'guard', '~> 2.19', '>= 2.19.1'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  
  # Performance & Observability (Dev)
  gem 'bullet', '~> 8.1'
  gem 'prosopite', '~> 2.1', '>= 2.1.2'
end

gem_group :development do
  gem 'letter_opener', '~> 1.10'
  gem 'letter_opener_web', '~> 3.0'
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
  gem 'stripe', '~> 17.2'
end

# 5. Vector Database
if @install_vector_db
  gem 'pgvector', '~> 0.3.2'
  gem 'neighbor', '~> 0.6.0'
  gem 'parallel', '~> 1.27'
end

# 6. AI Services
if @install_gemini || @install_local
  gem 'faraday', '~> 2.14'
  gem 'json', '~> 2.18'
  gem 'ruby-openai', '~> 8.3'
end