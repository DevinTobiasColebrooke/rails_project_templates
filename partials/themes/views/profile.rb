def setup_admin_profile_view
  create_file "app/views/admin/profiles/edit.html.erb", <<~ERB
    <div class="max-w-2xl mx-auto">
      <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-bold text-gray-800">Edit Your Profile</h1>
      </div>
      
      <%= form_with(model: @user, url: admin_profile_path, method: :patch, class: "bg-white p-8 rounded-lg shadow-sm border border-gray-200 space-y-6") do |f| %>
        <% if @user.errors.any? %>
          <div class="bg-red-50 text-red-600 p-4 rounded text-sm mb-4">
            <%= @user.errors.full_messages.to_sentence %>
          </div>
        <% end %>

        <div>
          <%= f.label :email_address, class: "block text-sm font-medium text-gray-700" %>
          <%= f.email_field :email_address, class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" %>
        </div>

        <div class="pt-4 border-t border-gray-100">
          <h3 class="text-sm font-medium text-gray-900 mb-2">Change Password</h3>
          <p class="text-xs text-gray-500 mb-4">Leave blank if you don't want to change it.</p>
          
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
          <%= link_to "Cancel", admin_root_path, class: "mr-3 inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50" %>
          <%= f.submit "Update Profile", class: "inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 cursor-pointer" %>
        </div>
      <% end %>
    </div>
  ERB
end