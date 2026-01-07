def setup_shared_partials
  # 1. Tailwind Flash Messages
  create_file 'app/views/shared/_flash.html.erb', <<~ERB
    <% flash.each do |type, message| %>
      <% classes = (type.to_s == 'notice' ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800") %>
      <div class="p-4 mb-4 rounded <%= classes %>"><%= message %></div>
    <% end %>
  ERB

  # 2. Navigation Menu
  # Conditionally generate auth links to prevent NameError if auth is skipped
  auth_section = ""
  if @install_auth
    auth_section = <<~ERB
      <% if defined?(current_user) && current_user %>
          <span><%= current_user.email_address %></span>
          <%= button_to "Sign out", session_path, method: :delete, class: "inline bg-red-600 px-3 py-1 rounded" %>
        <% else %>
          <%= link_to "Login", new_session_path, class: "hover:text-gray-300" %>
          <%= link_to "Sign Up", new_registration_path, class: "bg-blue-600 px-3 py-1 rounded" %>
        <% end %>
    ERB
  else
    auth_section = "<!-- Authentication skipped -->"
  end

  create_file 'app/views/shared/_menu.html.erb', <<~ERB
    <nav class="bg-gray-800 p-4 text-white flex justify-between items-center">
      <div>
        <%= link_to "App", root_path, class: "font-bold text-xl" %>
      </div>
      <div class="space-x-4">
        #{auth_section.strip}
      </div>
    </nav>
  ERB
end