# template.rb

# ==============================================================================
# 1. Wizard / User Configuration
# ==============================================================================
puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

install_ui   = yes?("🎨  Add UI Structure (Tailwind, Home, Menu, Flash)?")
install_auth = yes?("🔐  Add Authentication (Rails 8 Native + Registration)?")
if install_auth
  install_verify = yes?("    📧  Add Email Verification?")
end

puts "\n🤖  AI Configuration"
install_gemini = yes?("    Add Google Gemini Service?")
install_local  = yes?("    Add Local AI (Llama via Windows/WSL)?")
install_rag    = yes?("    Add RAG Tools (Ferrum, Readability, Pgvector)?")

# ==============================================================================
# 2. Gem Setup
# ==============================================================================
puts "\n📦  Defining Gems..."

# Use gem_group for specific environments
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

# AI Specific Gems
if install_gemini || install_local || install_rag
  gem "faraday", "~> 2.14"
  gem "json"
end

if install_gemini || install_local
  gem "ruby-openai", "~> 6.0"
end

if install_rag
  gem "ferrum"
  gem "ruby-readability", require: "readability"
  gem "nokogiri", "~> 1.18"
  gem "pgvector", "~> 0.2"
  gem "neighbor"
  gem "parallel"
end

# ==============================================================================
# 3. Setup Modules
# ==============================================================================

def setup_testing
  puts "🧪  Configuring RSpec..."
  generate 'rspec:install'
  append_to_file '.rspec', '--format documentation'
  
  # Configure FactoryBot
  inject_into_file 'spec/rails_helper.rb', after: "RSpec.configure do |config|\n" do
    "  config.include FactoryBot::Syntax::Methods\n"
  end

  # Configure Generators
  inject_into_file 'config/application.rb', after: "config.generators.system_tests = nil\n" do
    <<-RUBY
    config.generators do |g|
      g.test_framework :rspec, fixtures: true, view_specs: false, helper_specs: false, routing_specs: false, request_specs: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    RUBY
  end
end

def setup_ui_layout
  puts "🎨  Scaffolding UI..."
  
  # Tailwind Flash Messages
  create_file 'app/views/shared/_flash.html.erb', <<~ERB
    <% flash.each do |type, message| %>
      <% classes = (type.to_s == 'notice' ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800") %>
      <div class="p-4 mb-4 rounded <%= classes %>"><%= message %></div>
    <% end %>
  ERB

  # Menu
  create_file 'app/views/shared/_menu.html.erb', <<~ERB
    <nav class="bg-gray-800 p-4 text-white flex justify-between items-center">
      <div>
        <%= link_to "App", root_path, class: "font-bold text-xl" %>
      </div>
      <div class="space-x-4">
        <% if defined?(current_user) && current_user %>
          <span><%= current_user.email_address %></span>
          <%= button_to "Sign out", session_path, method: :delete, class: "inline bg-red-600 px-3 py-1 rounded" %>
        <% else %>
          <%= link_to "Login", new_session_path, class: "hover:text-gray-300" %>
          <%= link_to "Sign Up", new_registration_path, class: "bg-blue-600 px-3 py-1 rounded" %>
        <% end %>
      </div>
    </nav>
  ERB

  # Layout
  gsub_file 'app/views/layouts/application.html.erb', /<body[^>]*>(.*?)<\/body>/m do
    <<-ERB
  <body class="bg-gray-50 text-gray-900">
    <%= render 'shared/menu' %>
    <main class="container mx-auto px-4 py-8">
      <%= render 'shared/flash' %>
      <%= yield %>
    </main>
  </body>
    ERB
  end

  # Home Controller
  generate "controller", "home index --skip-routes"
  route 'root "home#index"'
end

def setup_authentication(with_verify)
  puts "🔐  Generating Authentication..."
  rails_command "generate authentication"

  # Registration Controller
  create_file 'app/controllers/registrations_controller.rb', <<~RUBY
    class RegistrationsController < ApplicationController
      allow_unauthenticated_access only: %i[new create]
      def new
        @user = User.new
      end
      def create
        @user = User.new(params.require(:user).permit(:email_address, :password, :password_confirmation))
        if @user.save
          start_new_session_for @user
          redirect_to root_path, notice: "Welcome!"
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  RUBY
  
  route "resource :registration, only: %i[new create]"
  
  # Registration View
  create_file 'app/views/registrations/new.html.erb', <<~ERB
    <div class="max-w-md mx-auto bg-white p-8 rounded shadow">
      <h1 class="text-2xl font-bold mb-4">Sign Up</h1>
      <%= form_with(model: @user, url: registration_path) do |form| %>
        <div class="mb-4">
          <%= form.label :email_address, class: "block text-gray-700" %>
          <%= form.email_field :email_address, class: "w-full border p-2 rounded" %>
        </div>
        <div class="mb-4">
          <%= form.label :password, class: "block text-gray-700" %>
          <%= form.password_field :password, class: "w-full border p-2 rounded" %>
        </div>
        <div class="mb-4">
          <%= form.label :password_confirmation, class: "block text-gray-700" %>
          <%= form.password_field :password_confirmation, class: "w-full border p-2 rounded" %>
        </div>
        <%= form.submit "Register", class: "w-full bg-blue-600 text-white p-2 rounded cursor-pointer" %>
      <% end %>
    </div>
  ERB

  # Current User Helper
  inject_into_file 'app/controllers/application_controller.rb', after: "allow_browser versions: :modern\n" do
    "  helper_method :current_user\n  def current_user\n    Current.session&.user\n  end\n"
  end

  if with_verify
    generate :migration, 'AddConfirmationToUsers', 'confirmation_token:string:index', 'confirmed_at:datetime'
    # (Email verification logic would go here similar to previous templates)
    route 'mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?'
  end
end

def setup_ai_configuration(use_gemini, use_local)
  puts "🤖  Configuring AI Services..."
  
  config_content = <<~RUBY
    # config/initializers/ai_config.rb
    module AiConfig
  RUBY

  if use_local
    # WSL 2 IP Detection Logic
    config_content += <<~RUBY
      # Detect Windows Host IP from WSL
      def self.detect_host_ip
        return 'localhost' unless File.exist?('/proc/version') && File.read('/proc/version').include?('Microsoft')
        ip = `grep nameserver /etc/resolv.conf | awk '{print $2}'`.strip
        ip.empty? ? 'localhost' : ip
      end

      # 1. Try to use the IP passed from the Batch script (fastest/safest)
      # 2. Fallback to auto-detection inside WSL
      WINDOWS_HOST = ENV.fetch('WINDOWS_HOST_IP') { detect_host_ip }
      
      LOCAL_LLM_URL = "http://\#{WINDOWS_HOST}:8080"
      LOCAL_EMBEDDING_URL = "http://\#{WINDOWS_HOST}:8081"
      LOCAL_MODEL_NAME = "Meta-Llama-3.1-8B-Instruct-Q8_0.guff"
    RUBY
  end

  if use_gemini
    config_content += <<~RUBY
      GEMINI_API_KEY = Rails.application.credentials.dig(:google, :gemini_key)
    RUBY
  end

  config_content += "  end\n"
  create_file "config/initializers/ai_config.rb", config_content
end

def setup_ai_services(use_gemini, use_local, use_rag)
  if use_gemini
    create_file "app/services/google_gemini_service.rb", <<~RUBY
      require "faraday"
      class GoogleGeminiService
        BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"
        def initialize(api_key: AiConfig::GEMINI_API_KEY)
          @api_key = api_key
        end
        def generate(prompt)
          # Implementation details...
        end
      end
    RUBY
  end

  if use_local
    create_file "app/services/local_llm_service.rb", <<~RUBY
      require "openai"
      class LocalLlmService
        def initialize
          @client = OpenAI::Client.new(access_token: "x", uri_base: AiConfig::LOCAL_LLM_URL)
        end
        
        def chat(prompt, system_message: "You are a helpful assistant.")
          response = @client.chat(
            parameters: {
              model: AiConfig::LOCAL_MODEL_NAME,
              messages: [
                { role: "system", content: system_message },
                { role: "user", content: prompt }
              ],
              temperature: 0.7
            }
          )
          response.dig("choices", 0, "message", "content")&.strip
        rescue => e
          Rails.logger.error "Local LLM Error: \#{e.message}"
          "Error connecting to Windows Local Host"
        end
      end
    RUBY
  end

  if use_rag
    # Generate RAG services (Ferrum, pgvector migration)
    generate :migration, "EnableVectorExtension"
    migration_file = Dir.glob("db/migrate/*_enable_vector_extension.rb").first
    inject_into_file migration_file, after: "def change\n" do
      "    enable_extension 'vector'\n"
    end if migration_file
  end
end

# ==============================================================================
# 4. Main Execution (After Bundle)
# ==============================================================================

after_bundle do
  # 1. Testing
  setup_testing
  run "bundle exec guard init rspec"

  # 2. UI
  setup_ui_layout if install_ui

  # 3. Auth
  setup_authentication(install_verify) if install_auth

  # 4. AI
  if install_gemini || install_local || install_rag
    setup_ai_configuration(install_gemini, install_local)
    setup_ai_services(install_gemini, install_local, install_rag)
  end

  # 5. Database
  rails_command "db:prepare"

  # 6. Linting
  run "bundle exec rubocop -a"

  puts "\n🎉  App Generation Complete!"
  puts "    Run 'bin/dev' to start."
  if install_local
    puts "⚠️   REMINDER: Start your Windows Llama Server on port 8080 (0.0.0.0)"
  end
end