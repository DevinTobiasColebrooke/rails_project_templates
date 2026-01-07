def setup_public_layout
  puts "    🎨  Generating #{@selected_theme.upcase} Layout..."

  case @selected_theme
  when 'pnw'
    setup_pnw_layout
  when 'caribbean'
    setup_caribbean_layout
  else
    setup_default_layout
  end
end

def setup_pnw_layout
  # Writes the Sidebar/Forest layout as the MAIN application layout
  create_file "app/views/layouts/application.html.erb", <<~ERB
    <!DOCTYPE html>
    <html class="h-full">
      <head>
        <title>App | <%= yield(:title) %></title>
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
        <style>
          /* PNW Color Palette & Typography */
          :root { --primary: #2C5530; --bg: #F0F4F2; --text: #1A2621; }
          body { font-family: "Georgia", serif; background-color: var(--bg); color: var(--text); }
        </style>
      </head>
      <body class="flex h-full overflow-hidden">
        
        <!-- PNW Sidebar -->
        <aside class="w-72 bg-[#1A2621] text-[#A3B18A] flex flex-col shadow-2xl relative z-10">
          <div class="p-8 border-b border-[#2C5530]">
            <h1 class="text-2xl font-serif text-white tracking-widest">EVERGREEN</h1>
          </div>
          
          <nav class="flex-1 p-6 space-y-4">
             <%= link_to "Dashboard", root_path, class: "block text-lg hover:text-white border-l-2 border-transparent hover:border-[#DAD7CD] pl-4 transition-all" %>
             
             <% if defined?(current_user) && current_user %>
               <div class="pt-8 mt-8 border-t border-[#2C5530]">
                 <p class="text-xs uppercase tracking-widest mb-4 opacity-50">Account</p>
                 <span class="block text-sm mb-2"><%= current_user.email_address %></span>
                 <%= button_to "Sign Out", session_path, method: :delete, class: "text-sm text-red-400 hover:text-red-300 cursor-pointer" %>
               </div>
             <% else %>
               <%= link_to "Log In", new_session_path, class: "block mt-8 text-white hover:text-[#DAD7CD]" %>
             <% end %>
          </nav>

          <div class="p-4 text-xs opacity-30 text-center">
            &copy; <%= Time.now.year %> Evergreen Inc.
          </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 overflow-y-auto p-12 bg-[#F0F4F2]">
          <div class="max-w-4xl mx-auto bg-white p-10 shadow-lg border-t-8 border-[#2C5530]">
            <%= render 'shared/flash' %>
            <%= yield %>
          </div>
        </main>
      </body>
    </html>
  ERB
end

def setup_caribbean_layout
  # Writes the Sticky Header/Beach layout as the MAIN application layout
  create_file "app/views/layouts/application.html.erb", <<~ERB
    <!DOCTYPE html>
    <html>
      <head>
        <title>Oasis | <%= yield(:title) %></title>
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
        <style>
           /* Caribbean Palette & Typography */
           :root { --primary: #0EA5E9; --bg-grad-start: #FAFDFF; --bg-grad-end: #FFF7ED; }
           body { font-family: system-ui, -apple-system, sans-serif; }
           .glass-header { 
             background: rgba(255, 255, 255, 0.7); 
             backdrop-filter: blur(12px); 
             border-bottom: 1px solid rgba(255,255,255,0.5); 
           }
        </style>
      </head>
      <body class="min-h-screen bg-gradient-to-br from-cyan-50 via-white to-orange-50 text-slate-700">
        
        <!-- Sticky Glass Header -->
        <header class="glass-header fixed top-0 w-full z-50 px-8 py-4 flex justify-between items-center transition-all duration-300">
          <div class="text-2xl font-bold text-sky-500 tracking-tight flex items-center gap-2">
            <span>☀️</span> Oasis
          </div>
          
          <nav class="flex items-center space-x-6 font-medium text-slate-600">
            <%= link_to "Home", root_path, class: "hover:text-sky-500 transition" %>
            
            <% if defined?(current_user) && current_user %>
               <div class="flex items-center gap-4 ml-4 pl-4 border-l border-slate-300">
                 <span class="text-xs"><%= current_user.email_address %></span>
                 <%= button_to "Sign Out", session_path, method: :delete, class: "bg-orange-100 text-orange-600 px-4 py-1 rounded-full text-sm hover:bg-orange-200 cursor-pointer" %>
               </div>
            <% else %>
               <%= link_to "Log In", new_session_path, class: "bg-sky-500 text-white px-5 py-2 rounded-full shadow-lg shadow-sky-200 hover:bg-sky-600 transition" %>
            <% end %>
          </nav>
        </header>

        <!-- Fluid Content -->
        <main class="container mx-auto px-4 pt-32 pb-12">
           <div class="bg-white/70 backdrop-blur-md rounded-[2rem] p-10 shadow-xl border border-white/60 min-h-[50vh]">
              <%= render 'shared/flash' %>
              <%= yield %>
           </div>
        </main>
      </body>
    </html>
  ERB
end

def setup_default_layout
  # The standard layout (uses menu partial)
  gsub_file 'app/views/layouts/application.html.erb', /<body[^>]*>(.*?)<\/body>/m do
    <<-ERB
  <body class="bg-gray-50 text-gray-900 font-sans">
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