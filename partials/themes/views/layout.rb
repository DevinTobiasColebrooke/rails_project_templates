def setup_public_layout
  # Load layout partials so methods are available
  apply File.join(__dir__, 'layouts', 'pnw.rb')
  apply File.join(__dir__, 'layouts', 'caribbean.rb')
  apply File.join(__dir__, 'layouts', 'default.rb')
  apply File.join(__dir__, 'layouts', 'admin.rb')
  apply File.join(__dir__, 'layouts', 'none.rb')

  puts "    🎨  Generating #{@selected_theme.upcase} Layout..."

  case @selected_theme
  when 'pnw'
    setup_pnw_layout
  when 'caribbean'
    setup_caribbean_layout
  when 'none'
    setup_none_layout
  else
    setup_default_layout
  end
end
