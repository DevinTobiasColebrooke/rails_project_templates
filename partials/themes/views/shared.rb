def setup_shared_partials
  # 1. Tailwind Flash Messages
  create_file 'app/views/shared/_flash.html.erb', <<~ERB
    <% flash.each do |type, message| %>
      <% classes = (type.to_s == 'notice' ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800") %>
      <div class="p-4 mb-4 rounded <%= classes %>"><%= message %></div>
    <% end %>
  ERB

  # 2. Navigation Menu (Primarily used by the Default theme)
  # Conditionally generate auth links to prevent NameError if auth is skipped
  auth_section = ""
  if @install_auth
    auth_section = <<~ERB
      <% if defined?(current_user) && current_user %>
          <div class="flex items-center gap-4">
            <span class="text-sm opacity-80"><%= current_user.email_address %></span>
            <%= button_to "Sign out", session_path, method: :delete, class: "inline bg-red-600 hover:bg-red-700 px-3 py-1 rounded transition text-sm cursor-pointer" %>
          </div>
        <% else %>
          <div class="space-x-2">
            <%= link_to "Login", new_session_path, class: "hover:text-gray-300 text-sm" %>
            <%= link_to "Sign Up", new_registration_path, class: "bg-blue-600 hover:bg-blue-700 px-3 py-1 rounded transition text-sm" %>
          </div>
        <% end %>
    ERB
  else
    auth_section = "<!-- Authentication skipped -->"
  end

  create_file 'app/views/shared/_menu.html.erb', <<~ERB
    <nav class="bg-gray-800 p-4 text-white flex justify-between items-center shadow-md">
      <div>
        <%= link_to "App", root_path, class: "font-bold text-xl tracking-tight" %>
      </div>
      <div class="flex items-center">
        #{auth_section.strip}
      </div>
    </nav>
  ERB
end