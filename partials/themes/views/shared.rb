def setup_shared_partials
  # 1. Tailwind Flash Messages (themed via design-system brand tokens)
  create_file 'app/views/shared/_flash.html.erb', <<~ERB
    <% flash.each do |type, message| %>
      <% notice = type.to_s == 'notice' %>
      <div class="mb-4 rounded-md border px-4 py-3 bg-brand-surface text-brand-text-primary <%= notice ? 'border-brand-earnings' : 'border-brand-danger' %>">
        <%= message %>
      </div>
    <% end %>
  ERB

  # 2. Navigation Menu (themed via design-system brand tokens)
  # Conditionally generate auth links to prevent NameError if auth is skipped
  auth_section = ""
  if @install_auth
    auth_section = <<~ERB
      <% if defined?(current_user) && current_user %>
          <div class="flex items-center gap-4">
            <span class="text-sm text-brand-text-muted"><%= current_user.email_address %></span>
            <%= button_to "Sign out", session_path, method: :delete, class: "ds-btn-secondary cursor-pointer" %>
          </div>
        <% else %>
          <div class="flex items-center gap-3">
            <%= link_to "Login", new_session_path, class: "text-sm text-brand-text-secondary hover:text-brand-text-primary" %>
            <%= link_to "Sign Up", new_registration_path, class: "ds-btn-primary" %>
          </div>
        <% end %>
    ERB
  else
    auth_section = "<!-- Authentication skipped -->"
  end

  create_file 'app/views/shared/_menu.html.erb', <<~ERB
    <nav class="bg-brand-surface border-b border-brand-border-default px-6 py-4 flex justify-between items-center shadow-sm">
      <div>
        <%= link_to "App", root_path, class: "font-display font-bold text-xl tracking-tight text-brand-text-primary" %>
      </div>
      <div class="flex items-center">
        #{auth_section.strip}
      </div>
    </nav>
  ERB
end
