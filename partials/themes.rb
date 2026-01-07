def setup_themes_and_admin
  # 1. Load View Generators
  apply File.join(__dir__, 'themes', 'views.rb')
  apply File.join(__dir__, 'themes', 'views', 'layout.rb')
  apply File.join(__dir__, 'themes', 'views', 'shared.rb')

  # 2. Load Admin Generators (if selected)
  if @install_admin
    apply File.join(__dir__, 'themes', 'controllers.rb')
    apply File.join(__dir__, 'themes', 'routes.rb')
    apply File.join(__dir__, 'themes', 'views', 'dashboard.rb')
    apply File.join(__dir__, 'themes', 'views', 'users.rb')
    apply File.join(__dir__, 'themes', 'views', 'profile.rb')
  end

  # 3. Setup Home Controller (Standard)
  setup_home_controller

  # 4. Setup Shared Components (Menu, Flash)
  setup_shared_views

  # 5. Generate the Selected Theme Layout (PNW, Caribbean, or Default)
  # This relies on the choice made in the Wizard
  setup_public_layout

  # 6. Setup Admin (if selected)
  if @install_admin
    setup_admin_controllers
    setup_admin_routes
    setup_admin_layout # Defined in themes/views/layout.rb
    setup_admin_dashboard_view
    setup_admin_users_views
    setup_admin_profile_view
  end
end

def setup_home_controller
  generate "controller", "home index --skip-routes"
  route 'root "home#index"'
end