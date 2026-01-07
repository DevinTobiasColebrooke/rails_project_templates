def setup_admin_layout
  # Admin layout remains standard regardless of public theme
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
      <body class="bg-gray-100 font-sans text-gray-900 flex h-screen">
        <aside class="w-64 bg-slate-900 text-slate-300 flex flex-col">
          <div class="p-6 font-bold text-xl text-white tracking-wide border-b border-slate-800">Admin Panel</div>
          <nav class="flex-1 px-4 space-y-2 mt-4">
             <%= link_to "Dashboard", admin_root_path, class: "block py-2 px-3 rounded hover:bg-slate-800 hover:text-white transition-colors" %>
             <%= link_to "Users", admin_users_path, class: "block py-2 px-3 rounded hover:bg-slate-800 hover:text-white transition-colors" %>
          </nav>
          
          <div class="p-4 border-t border-slate-800">
             <%= link_to "Back to App", root_path, class: "block py-2 px-3 rounded hover:bg-slate-800 text-slate-500 hover:text-white transition-colors text-sm" %>
          </div>
        </aside>
        
        <main class="flex-1 p-8 overflow-y-auto bg-gray-50">
          <% flash.each do |key, value| %>
            <div class="p-4 mb-4 text-sm text-center <%= key == 'notice' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700' %>">
              <%= value %>
            </div>
          <% end %>
          <%= yield %>
        </main>
      </body>
    </html>
  ERB
end