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