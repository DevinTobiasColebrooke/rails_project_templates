require 'json'

if @api_only
  puts '🤖 API Mode Detected.'
  puts ' Skipping UI, Admin, SEO, and Browser-Auth prompts.'

  @install_ui = false
  @install_chat_ui = false
  @install_admin = false
  @install_seo = false
  @install_auth = false
else
  @install_ui = yes?('🎨 Add UI (Tailwind, Flash, Menu)?')

  if @install_ui
    design_systems_dir = File.expand_path('../../themes/design_systems', __dir__)
    theme_slugs = Dir.children(design_systems_dir)
                     .select { |slug| File.directory?(File.join(design_systems_dir, slug)) }
                     .sort

    puts " 🎨 Select your application's design system:"
    theme_slugs.each_with_index do |slug, index|
      meta = JSON.parse(File.read(File.join(design_systems_dir, slug, 'system.json')))
      mode = meta['native_mode'] || (meta['is_dark'] ? 'dark' : 'light')
      puts format(' %<num>2d. %<name>-40s (%<mode>s)', num: index + 1, name: meta['name'] || slug, mode: mode)
    end

    theme_choice = ask(' -> Selection:', limited_to: (1..theme_slugs.size).map(&:to_s))
    @selected_theme = theme_slugs[theme_choice.to_i - 1]
    @selected_design_system_dir = File.join(design_systems_dir, @selected_theme)
    puts "    -> Applying #{@selected_theme} design system."

  else
    @selected_theme = 'none'
  end

  @install_chat_ui = yes?(' 💬 Add AI Chat UI (Conversational Interface)?')
  @install_admin = yes?('👑 Add Custom Admin Panel?')
  @install_auth = yes?('🔐 Add Authentication?')
  @install_verify = yes?(' 📧 Add Email Verification?') if @install_auth
  @install_seo = yes?(' Add SEO Tools (MetaTags, Sitemap)?')
end
