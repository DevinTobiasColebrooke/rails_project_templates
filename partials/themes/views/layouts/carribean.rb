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