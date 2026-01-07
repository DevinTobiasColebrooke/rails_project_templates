if @api_only
puts "🤖 API Mode Detected."
puts " Skipping UI, Admin, SEO, and Browser-Auth prompts."


@install_ui = false
@install_chat_ui = false
@install_admin = false
@install_seo = false
@install_auth = false
else
@install_ui = yes?("🎨 Add UI (Tailwind, Flash, Menu)?")

if @install_ui
puts " 🎨 Select your application's base theme:"
puts " 1. Default (Standard Top Bar)"
puts " 2. PNW (Evergreen, Sidebar, Serif Fonts)"
puts " 3. Caribbean (Beach, Sticky Header, Rounded Fonts)"
theme_choice = ask(" -> Selection:", limited_to: %w[1 2 3 default pnw caribbean])
@selected_theme = case theme_choice
                  when '2', 'pnw' then 'pnw'
                  when '3', 'caribbean' then 'caribbean'
                  else 'default'
                  end
puts "    -> Applying #{@selected_theme.upcase} theme structure."

else
@selected_theme = 'default'
end

@install_chat_ui = yes?(" 💬 Add AI Chat UI (Conversational Interface)?")
@install_admin = yes?("👑 Add Custom Admin Panel?")
@install_auth = yes?("🔐 Add Authentication?")
if @install_auth
@install_verify = yes?(" 📧 Add Email Verification?")
end
@install_seo = yes?(" Add SEO Tools (MetaTags, Sitemap)?")
end