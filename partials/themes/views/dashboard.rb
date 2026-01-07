def setup_admin_dashboard_view
  create_file "app/views/admin/dashboard/index.html.erb", <<~ERB
    <div class="flex items-center justify-between mb-8">
      <h1 class="text-3xl font-bold text-gray-800">Dashboard</h1>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
        <h2 class="text-gray-500 uppercase text-xs font-bold tracking-wider">Total Users</h2>
        <p class="text-4xl font-bold mt-2 text-indigo-600"><%= User.count rescue 0 %></p>
      </div>
      <!-- Add more metrics here -->
    </div>
  ERB
end