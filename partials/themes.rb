def setup_themes_and_admin
  puts "🎨  Setting up UI, Themes & Admin..."

  # Load sub-modules
  apply File.join(__dir__, 'themes', 'controllers.rb')
  apply File.join(__dir__, 'themes', 'views.rb')
  apply File.join(__dir__, 'themes', 'routes.rb')
  apply File.join(__dir__, 'themes', 'config.rb')
  apply File.join(__dir__, 'themes', 'helpers.rb')

  # 1. Base UI Scaffolding (Flash, Menu, Home)
  if @install_ui
    setup_shared_views    # Flash & Menu
    setup_public_layout   # Application.html.erb mods
    setup_home_controller # Home#Index
    setup_root_route
  end

  # 2. Theme Configuration (CSS Variables)
  if @install_ui || @install_admin
    setup_theme_config
    setup_theme_helpers
  end

  # 3. Admin Panel
  if @install_admin
    setup_admin_controllers
    setup_admin_views
    setup_admin_routes
  end
end