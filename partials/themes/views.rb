def setup_shared_views
  apply File.join(__dir__, 'views', 'shared.rb')
  setup_shared_partials
end

def setup_public_layout
  apply File.join(__dir__, 'views', 'layout.rb')
  setup_application_layout_modification
end

def setup_admin_views
  # Load sub-view partials
  apply File.join(__dir__, 'views', 'layout.rb')
  apply File.join(__dir__, 'views', 'dashboard.rb')
  apply File.join(__dir__, 'views', 'users.rb')
  apply File.join(__dir__, 'views', 'profile.rb')

  # Execute
  setup_admin_layout
  setup_admin_dashboard_view
  setup_admin_users_views
  setup_admin_profile_view
end