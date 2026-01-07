def setup_application_layout_modification
  puts "    🎨  Updating Application Layout (Menu & Flash)..."
  
  # Inject Menu and Flash into the main body
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
end

def setup_admin_layout
  create_file "app/views/layouts/admin.html.erb", <<~ERB
    <!DOCTYPE html>
    <html>
      <head>
        <title>Admin | <%= yield(:title) %></title>
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
      </head>
      <body class="bg-gray-100 font-sans text-gray-900">
        <div class="flex h-screen overflow-hidden">
          <!-- Sidebar -->
          <aside class="w-64 bg-slate-900 text-slate-300 flex flex-col">
            <div class="p-6 font-bold text-xl text-white tracking-wide border-b border-slate-800">Admin Panel</div>
            
            <nav class="flex-1 mt-6 px-4 space-y-2">
              <%= link_to "Dashboard", admin_root_path, class: "block py-2 px-3 rounded hover:bg-slate-800 hover:text-white transition-colors" %>
              <%= link_to "User Management", admin_users_path, class: "block py-2 px-3 rounded hover:bg-slate-800 hover:text-white transition-colors" %>
            </nav>

            <div class="p-4 border-t border-slate-800 space-y-2">
              <%= link_to "My Profile", edit_admin_profile_path, class: "block py-2 px-3 rounded hover:bg-slate-800 hover:text-white transition-colors text-sm" %>
              <%= link_to "Back to App", root_path, class: "block py-2 px-3 rounded hover:bg-slate-800 text-slate-500 hover:text-white transition-colors text-sm" %>
              <% if defined?(session_path) %>
                <%= button_to "Log Out", session_path, method: :delete, class: "w-full text-left block py-2 px-3 rounded hover:bg-red-900/30 text-red-400 hover:text-red-300 transition-colors text-sm cursor-pointer" %>
              <% end %>
            </div>
          </aside>
          
          <!-- Content -->
          <main class="flex-1 overflow-y-auto bg-gray-50">
            <!-- Flash Messages -->
             <% flash.each do |key, value| %>
              <div class="p-4 mb-4 text-sm text-center <%= key == 'notice' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700' %>">
                <%= value %>
              </div>
            <% end %>

            <div class="p-8">
              <%= yield %>
            </div>
          </main>
        </div>
      </body>
    </html>
  ERB
end