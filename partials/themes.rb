def setup_themes_and_admin
  puts "🎨  Setting up Custom Themes & Admin Structure..."

  # --- A. Custom Admin Panel ---
  # We create a base controller that inherits from ApplicationController
  # but enforces the 'allow_unauthenticated_access' rules strictly.
  create_file "app/controllers/admin/base_controller.rb", <<~RUBY
    module Admin
      class BaseController < ApplicationController
        # Ensure only authenticated users can access admin
        # You should add a role check here (e.g., unless current_user.admin?)
        before_action :resume_session
        before_action :require_authentication
        
        layout 'admin'
      end
    end
  RUBY

  create_file "app/controllers/admin/dashboard_controller.rb", <<~RUBY
    module Admin
      class DashboardController < BaseController
        def index
        end
      end
    end
  RUBY
  
  create_file "app/views/layouts/admin.html.erb", <<~ERB
    <!DOCTYPE html>
    <html>
      <head>
        <title>Admin | <%= yield(:title) %></title>
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        <%= stylesheet_link_tag "tailwind", "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
      </head>
      <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen overflow-hidden">
          <!-- Sidebar -->
          <aside class="w-64 bg-gray-900 text-white">
            <div class="p-4 font-bold text-xl">Admin Panel</div>
            <nav class="mt-4">
              <%= link_to "Dashboard", admin_root_path, class: "block py-2 px-4 hover:bg-gray-800" %>
              <%= link_to "Back to App", root_path, class: "block py-2 px-4 hover:bg-gray-800 text-gray-400" %>
            </nav>
          </aside>
          <!-- Content -->
          <main class="flex-1 overflow-y-auto p-8">
            <%= yield %>
          </main>
        </div>
      </body>
    </html>
  ERB
  
  create_file "app/views/admin/dashboard/index.html.erb", <<~ERB
    <h1 class="text-3xl font-bold mb-6">Dashboard</h1>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-white p-6 rounded shadow">
        <h2 class="text-gray-500 uppercase text-xs font-bold">Total Users</h2>
        <p class="text-3xl font-bold"><%= User.count rescue 0 %></p>
      </div>
      <!-- Add more cards here -->
    </div>
  ERB

  route "namespace :admin do\n    root to: 'dashboard#index'\n  end"

  # --- B. Custom Themes via CSS Variables ---
  # This allows you to define palettes in a file and swap them easily.
  
  create_file "config/themes.yml", <<~YAML
    default:
      primary: "#4F46E5"   # Indigo 600
      secondary: "#10B981" # Emerald 500
      background: "#F3F4F6"
      text: "#1F2937"
    dark:
      primary: "#818CF8"
      secondary: "#34D399"
      background: "#111827"
      text: "#F9FAFB"
  YAML

  # We add a helper to inject these into the :root scope
  create_file "app/helpers/theme_helper.rb", <<~RUBY
    module ThemeHelper
      def theme_css_variables
        # In production, cache this. For now, we load it dynamically.
        themes = YAML.load_file(Rails.root.join('config/themes.yml'))
        current_theme = themes['default'] # Or current_user.theme
        
        css_lines = current_theme.map do |key, value|
          "--theme-\#{key}: \#{value};"
        end.join(" ")
        
        ":root { \#{css_lines} }".html_safe
      end
    end
  RUBY

  inject_into_file 'app/views/layouts/application.html.erb', in_before: "</head>" do
    "\n    <style><%= theme_css_variables %></style>\n"
  end
end