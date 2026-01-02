# ==============================================================================
# Helper Methods
# ==============================================================================

def source_paths
  [__dir__]
end

def setup_gems
  puts "📦 Adding gems..."
  
  # RSpec & Testing
  group :development, :test do
    gem 'rspec-rails', '~> 7.0'
    gem 'factory_bot_rails', '~> 6.0'
    gem 'guard', '~> 2.19'
    gem 'guard-rspec', '~> 4.7'
    gem 'rubocop', require: false
    gem 'rubocop-rails', require: false
  end

  # Development specific
  group :development do
    gem 'letter_opener', '~> 1.0'
    gem 'letter_opener_web', '~> 3.0'
  end
end

def setup_rspec_config
  puts "⚙️ Configuring RSpec..."
  generate 'rspec:install'
  
  # Configure .rspec
  append_to_file '.rspec', '--format documentation'

  # Configure FactoryBot syntax
  inject_into_file 'spec/rails_helper.rb', after: "RSpec.configure do |config|\n" do
    "  config.include FactoryBot::Syntax::Methods\n"
  end

  # Configure Generators
  inject_into_file 'config/application.rb', after: "config.generators.system_tests = nil\n" do
    <<-RUBY
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
    RUBY
  end
end

def setup_rubocop_config
  puts "👮 Configuring Rubocop..."
  create_file '.rubocop.yml', <<~YML
    inherit_gem:
      rubocop-rails-omakase: rubocop.yml

    require:
      - rubocop-rails

    AllCops:
      TargetRubyVersion: 3.2
      Exclude:
        - 'db/schema.rb'
        - 'bin/*'
        - 'node_modules/**/*'
        - 'config/**/*'
        - 'vendor/**/*'

    Layout/LineLength:
      Max: 200

    Rails:
      Enabled: true
  YML
end

def setup_ui_layout
  puts "🎨 Setting up UI Layout..."
  
  # 1. Update Application Layout
  gsub_file 'app/views/layouts/application.html.erb', /<body[^>]*>(.*?)<\/body>/m do
    <<-ERB
  <body class="bg-gray-50 text-gray-900 font-sans antialiased">
    <main class="flex flex-col min-h-screen">
      <%= render 'shared/menu' %>
      <%= render 'shared/flash' %>
      <div class="flex-grow w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <%= yield %>
      </div>
    </main>
  </body>
    ERB
  end

  # 2. Create Menu Partial
  create_file 'app/views/shared/_menu.html.erb', <<~ERB
    <nav class="bg-white shadow-sm border-b border-gray-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex">
            <div class="flex-shrink-0 flex items-center">
              <%= link_to "App Name", root_path, class: "text-xl font-bold text-indigo-600" %>
            </div>
            <div class="hidden sm:ml-6 sm:flex sm:space-x-8">
              <%= link_to "Home", root_path, class: "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium" %>
              
              <% if defined?(PagesController) %>
                 <%= link_to "About", pages_about_path, class: "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium" %>
              <% end %>
            </div>
          </div>
          <div class="flex items-center">
            <% if respond_to?(:current_user) && current_user %>
               <span class="text-sm text-gray-500 mr-4"><%= current_user.email_address %></span>
               <%= button_to "Sign out", session_path, method: :delete, class: "text-sm text-red-600 hover:text-red-900 bg-transparent border-0 cursor-pointer" %>
            <% else %>
               <%= link_to "Sign in", new_session_path, class: "text-sm text-indigo-600 hover:text-indigo-900 mr-4" %>
               <%= link_to "Register", new_registration_path, class: "bg-indigo-600 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-indigo-700" %>
            <% end %>
          </div>
        </div>
      </div>
    </nav>
  ERB

  # 3. Create Flash Partial
  create_file 'app/views/shared/_flash.html.erb', <<~ERB
    <% flash.each do |type, message| %>
      <% 
         classes = case type.to_s
           when "notice" then "bg-green-100 text-green-800 border-green-300"
           when "alert" then "bg-red-100 text-red-800 border-red-300"
           else "bg-gray-100 text-gray-800 border-gray-300"
         end 
      %>
      <div class="max-w-7xl mx-auto px-4 mt-4">
        <div class="border-l-4 p-4 rounded-r <%= classes %>">
          <p class="font-medium"><%= message %></p>
        </div>
      </div>
    <% end %>
  ERB
end

def setup_home_and_pages
  puts "🏠 Generating Home and Static Pages..."
  
  generate "controller", "home index --skip-routes"
  generate "controller", "pages about --skip-routes"

  route 'root "home#index"'
  route 'get "pages/about"'

  # Home View
  create_file 'app/views/home/index.html.erb', force: true do
    <<-ERB
      <div class="text-center py-20">
        <h1 class="text-5xl font-extrabold text-gray-900 tracking-tight sm:text-6xl mb-6">
          Welcome to <span class="text-indigo-600">Rails 8</span>
        </h1>
        <p class="mt-4 text-xl text-gray-500 max-w-2xl mx-auto">
          This template comes pre-configured with RSpec, Tailwind, and custom Authentication logic.
        </p>
        
        <div class="mt-10 flex justify-center gap-4">
           <% if Rails.env.development? %>
             <%= link_to "Check Emails", letter_opener_web_path, class: "px-6 py-3 border border-gray-300 shadow-sm text-base font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50", target: "_blank" %>
           <% end %>
        </div>
      </div>
    ERB
  end

  # Allow unauthenticated access to home
  inject_into_file 'app/controllers/home_controller.rb', after: "class HomeController < ApplicationController\n" do
    "  allow_unauthenticated_access\n"
  end
  
  inject_into_file 'app/controllers/pages_controller.rb', after: "class PagesController < ApplicationController\n" do
    "  allow_unauthenticated_access\n"
  end
end

def setup_rails_8_authentication
  puts "🔐 Generating Rails 8 Authentication..."
  
  # Run the native generator
  rails_command "generate authentication"
  
  # Add Current User helper
  inject_into_file 'app/controllers/application_controller.rb', after: "allow_browser versions: :modern\n" do
    <<-RUBY
    helper_method :current_user
    def current_user
      Current.session&.user
    end
    RUBY
  end
end

def enhance_authentication_with_registration
  puts "📝 Adding Registration Logic..."

  # 1. Registration Controller
  create_file 'app/controllers/registrations_controller.rb', <<~RUBY
    class RegistrationsController < ApplicationController
      allow_unauthenticated_access only: %i[new create]
      
      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)
        if @user.save
          start_new_session_for @user
          redirect_to root_path, notice: "Welcome! You have signed up successfully."
        else
          render :new, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email_address, :password, :password_confirmation)
      end
    end
  RUBY

  # 2. Add Route
  route "resource :registration, only: %i[new create]"

  # 3. Add Validations to User
  inject_into_file 'app/models/user.rb', after: "has_secure_password\n" do
    <<-RUBY
  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, on: :create
    RUBY
  end

  # 4. View
  create_file 'app/views/registrations/new.html.erb', <<~ERB
    <div class="max-w-md mx-auto mt-10">
      <h1 class="text-3xl font-bold mb-6 text-center">Register</h1>
      
      <%= form_with(model: @user, url: registration_path, class: "bg-white p-6 rounded-lg shadow-md space-y-4") do |form| %>
        
        <% if @user.errors.any? %>
          <div class="bg-red-50 text-red-500 p-4 rounded mb-4">
            <ul class="list-disc list-inside">
              <% @user.errors.full_messages.each do |message| %>
                <li><%= message %></li>
              <% end %>
            </ul>
          </div>
        <% end %>

        <div>
          <%= form.label :email_address, class: "block font-medium text-gray-700" %>
          <%= form.email_field :email_address, required: true, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm p-2 border" %>
        </div>

        <div>
          <%= form.label :password, class: "block font-medium text-gray-700" %>
          <%= form.password_field :password, required: true, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm p-2 border" %>
        </div>

        <div>
          <%= form.label :password_confirmation, class: "block font-medium text-gray-700" %>
          <%= form.password_field :password_confirmation, required: true, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm p-2 border" %>
        </div>

        <div>
          <%= form.submit "Sign Up", class: "w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 cursor-pointer" %>
        </div>
        
        <div class="text-center text-sm text-gray-500">
           Already have an account? <%= link_to "Sign in", new_session_path, class: "text-indigo-600 hover:text-indigo-500" %>
        </div>
      <% end %>
    </div>
  ERB
end

def setup_email_verification
  puts "📧 Setting up Email Verification..."
  
  # 1. Migration
  generate :migration, 'AddConfirmationToUsers', 'confirmation_token:string:index', 'confirmed_at:datetime'
  
  # 2. Update User Model
  inject_into_file 'app/models/user.rb', after: "has_secure_password\n" do
    <<-RUBY
  has_secure_token :confirmation_token
    RUBY
  end

  inject_into_file 'app/models/user.rb', before: "end\n" do
    <<-RUBY

  def confirm!
    update!(confirmed_at: Time.current, confirmation_token: nil)
  end

  def confirmed?
    confirmed_at.present?
  end

  def send_confirmation_instructions
    regenerate_confirmation_token
    UserMailer.confirmation_instructions(self).deliver_later
  end
    RUBY
  end

  # 3. Update Auth Concern (Handling the Rails 8 Auth generation)
  # We look for the `require_authentication` method
  gsub_file 'app/controllers/concerns/authentication.rb', /def require_authentication\n(.*?)end/m do
    <<-RUBY
  def require_authentication
    resume_session || request_authentication
    if authenticated? && !Current.user.confirmed?
       redirect_to root_path, alert: "Please check your email to confirm your account."
    end
  end
    RUBY
  end

  # 4. Generate Mailer
  generate :mailer, 'UserMailer'
  inject_into_file 'app/mailers/user_mailer.rb', after: "class UserMailer < ApplicationMailer\n" do
    <<-RUBY
  def confirmation_instructions(user)
    @user = user
    @confirmation_url = confirm_registration_url(token: @user.confirmation_token)
    mail(to: @user.email_address, subject: "Confirm your account")
  end
    RUBY
  end
  
  create_file 'app/views/user_mailer/confirmation_instructions.html.erb', <<~ERB
    <h1>Welcome!</h1>
    <p>Please confirm your account:</p>
    <%= link_to 'Confirm Account', @confirmation_url %>
  ERB

  # 5. Update Registration Controller for Sending Email
  inject_into_file 'app/controllers/registrations_controller.rb', after: "if @user.save\n" do
    "      @user.send_confirmation_instructions\n"
  end

  # 6. Add Confirm Action to RegistrationController
  inject_into_file 'app/controllers/registrations_controller.rb', before: "private" do
    <<-RUBY
  def confirm
    @user = User.find_by(confirmation_token: params[:token])
    if @user
      @user.confirm!
      start_new_session_for @user
      redirect_to root_path, notice: "Account confirmed successfully!"
    else
      redirect_to root_path, alert: "Invalid confirmation token."
    end
  end

    RUBY
  end
  
  # Allow unauthenticated access to confirm
  inject_into_file 'app/controllers/registrations_controller.rb', after: "allow_unauthenticated_access only: %i[new create" do
    " confirm"
  end

  # 7. Update Routes
  route "get 'confirm_registration', to: 'registrations#confirm'"

  # 8. Configure Letter Opener
  route 'mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?'
  environment 'config.action_mailer.default_url_options = { host: "localhost", port: 3000 }', env: 'development'
  environment 'config.action_mailer.delivery_method = :letter_opener', env: 'development'
  environment 'config.action_mailer.perform_deliveries = true', env: 'development'
end

# ==============================================================================
# Main Execution Flow
# ==============================================================================

# 1. Gems
setup_gems

# 2. Configuration Options (Wizard)
install_auth = yes?("🔒 Do you want to generate Authentication (Rails 8)?")
install_verification = install_auth && yes?("📧 Do you want to add Email Verification?")
install_ui = yes?("🎨 Do you want to generate Home page, Menu, and Flash messages?")

# 3. Post-Bundle Execution
after_bundle do
  # Basic Setup
  setup_rspec_config
  setup_rubocop_config
  
  if install_ui
    setup_ui_layout
    setup_home_and_pages
  end

  if install_auth
    setup_rails_8_authentication
    enhance_authentication_with_registration
  end

  if install_verification
    setup_email_verification
  end

  # Database Setup
  rails_command "db:create"
  rails_command "db:migrate"
  rails_command "db:test:prepare"

  # Autofix style
  run "bundle exec rubocop -a"

  # Initialize Guard
  run "bundle exec guard init rspec"

  puts "\n\n🎉 Template installation complete!"
  puts "   Run 'bin/dev' to start your server."
end