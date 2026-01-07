def setup_admin_users_views
  # Index View
  create_file "app/views/admin/users/index.html.erb", <<~ERB
    <div class="flex items-center justify-between mb-6">
      <h1 class="text-2xl font-bold text-gray-800">User Management</h1>
      <%= link_to "Create User", new_admin_user_path, class: "bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition" %>
    </div>

    <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Created</th>
            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <% @users.each do |user| %>
            <tr>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= user.email_address %></td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= user.created_at.to_date %></td>
              <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-3">
                <%= link_to "Edit", edit_admin_user_path(user), class: "text-indigo-600 hover:text-indigo-900" %>
                <% unless user == current_user %>
                  <%= button_to "Delete", admin_user_path(user), method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "text-red-600 hover:text-red-900 inline bg-transparent cursor-pointer" %>
                <% end %>
              </td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
  ERB

  # Form Partial
  create_file "app/views/admin/users/_form.html.erb", <<~ERB
    <%= form_with(model: [:admin, user], class: "space-y-6 max-w-lg bg-white p-8 rounded-lg shadow-sm border border-gray-200") do |f| %>
      <% if user.errors.any? %>
        <div class="bg-red-50 text-red-600 p-4 rounded text-sm mb-4">
          <%= user.errors.full_messages.to_sentence %>
        </div>
      <% end %>

      <div>
        <%= f.label :email_address, class: "block text-sm font-medium text-gray-700" %>
        <%= f.email_field :email_address, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" %>
      </div>

      <div class="pt-4 border-t border-gray-100">
        <h3 class="text-sm font-medium text-gray-900 mb-2">Security</h3>
        <p class="text-xs text-gray-500 mb-4">Leave blank to keep existing password.</p>
        
        <div class="space-y-4">
          <div>
            <%= f.label :password, "New Password", class: "block text-sm font-medium text-gray-700" %>
            <%= f.password_field :password, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" %>
          </div>

          <div>
            <%= f.label :password_confirmation, class: "block text-sm font-medium text-gray-700" %>
            <%= f.password_field :password_confirmation, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" %>
          </div>
        </div>
      </div>

      <div class="flex justify-end pt-4">
        <%= link_to "Cancel", admin_users_path, class: "mr-3 inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" %>
        <%= f.submit class: "inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 cursor-pointer" %>
      </div>
    <% end %>
  ERB

  # New/Edit Views
  create_file "app/views/admin/users/new.html.erb", <<~ERB
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Create New User</h1>
    <%= render "form", user: @user %>
  ERB

  create_file "app/views/admin/users/edit.html.erb", <<~ERB
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Edit User</h1>
    <%= render "form", user: @user %>
  ERB
end