# partials/performance.rb

def setup_performance
  puts "🏎️  Configuring Performance & Observability..."

  # 1. Bullet (N+1 Detection)
  inject_into_file 'config/environments/development.rb', after: "config.action_mailer.raise_delivery_errors = true\n" do
    <<-RUBY

  # Bullet N+1 Query Detection
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end
    RUBY
  end

  # 2. Rack Attack
  create_file "config/initializers/rack_attack.rb", <<~RUBY
    class Rack::Attack
      # Throttle all requests by IP (300 requests per 5 minutes)
      throttle('req/ip', limit: 300, period: 5.minutes) do |req|
        req.ip
      end

      # Throttle login attempts
      throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
        if req.path == '/session' && req.post?
          req.ip
        end
      end
    end
  RUBY
  
  # Enable Rack Attack in application.rb
  inject_into_file 'config/application.rb', after: "class Application < Rails::Application\n" do
    "    config.middleware.use Rack::Attack\n"
  end

  # 3. Ahoy Analytics
  # FIX: Use external command to force loading of the new ahoy_matey gem
  run "bin/rails generate ahoy:install"
end