def setup_chat_ui
  puts "💬  Configuring AI Chat Interface..."

  # Load sub-modules
  apply File.join(__dir__, 'chat_ui', 'models.rb')
  apply File.join(__dir__, 'chat_ui', 'controllers.rb')
  apply File.join(__dir__, 'chat_ui', 'views.rb')
  apply File.join(__dir__, 'chat_ui', 'javascript.rb')
  apply File.join(__dir__, 'chat_ui', 'routes.rb')

  # Execute setup
  setup_chat_models
  setup_chat_controllers
  setup_chat_views
  setup_chat_javascript
  setup_chat_routes
end