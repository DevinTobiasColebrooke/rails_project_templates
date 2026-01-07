if @api_only
  puts "🤖  API Mode Detected."
  puts "    Skipping UI, Admin, SEO, and Browser-Auth prompts."
  
  @install_ui = false
  @install_chat_ui = false
  @install_admin = false
  @install_seo = false
  @install_auth = false 
else
  @install_ui    = yes?("🎨  Add UI (Tailwind, Flash, Menu, Custom Themes)?")
  @install_chat_ui = yes?("    💬  Add AI Chat UI (Conversational Interface)?")
  @install_admin = yes?("👑  Add Custom Admin Panel?")
  @install_auth  = yes?("🔐  Add Authentication?")
  if @install_auth
    @install_verify = yes?("    📧  Add Email Verification?")
  end
  @install_seo       = yes?("    Add SEO Tools (MetaTags, Sitemap)?")
end