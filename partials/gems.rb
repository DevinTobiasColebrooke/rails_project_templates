# partials/gems.rb
puts "\n📦  Defining Gems..."

gem_group :development, :test do
  gem 'rspec-rails', '~> 7.0'
  gem 'factory_bot_rails', '~> 6.0'
  gem 'guard', '~> 2.19'
  gem 'guard-rspec', '~> 4.7'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

gem_group :development do
  gem 'letter_opener', '~> 1.0'
  gem 'letter_opener_web', '~> 3.0'
end

# Stripe
if @install_stripe
  gem 'stripe', '~> 10.0'
end

# AI Specific Gems
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