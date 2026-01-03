# 1. Configuration Wizard
puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

@install_ui    = yes?("🎨  Add UI (Tailwind, Flash, Menu, Custom Themes)?")
@install_admin = yes?("👑  Add Custom Admin Panel?")
@install_auth  = yes?("🔐  Add Authentication?")
if @install_auth
  @install_verify = yes?("    📧  Add Email Verification?")
end

puts "\n🧱  Content & Data"
# Rich Text removed as requested
@install_seo       = yes?("    Add SEO Tools (MetaTags, Sitemap)?")
@install_api       = yes?("    Add API Services (Data.gov example)?")
# Prompts question removed from here to handle it smartly below

puts "\n💳  Payments"
@install_stripe = yes?("    Add Stripe Payments?")

puts "\n🧠  Knowledge Base"
@install_vector_db = yes?("    Add Vector Database (pgvector + Neighbor)?")

puts "\n🤖  AI Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
@install_local  = yes?("    Add Local AI (Llama via Windows/WSL)?")

if @install_gemini || @install_local
  @install_prompts = true
  puts "    -> 🧠 Prompt Management System auto-enabled for AI."
else
  @install_prompts = yes?("    Add Prompt Management System (Standalone)?")
end


puts "\n⚙️  Ops"
@install_ops = yes?("    Add Observability (RackAttack, Bullet, Ahoy, Scenic)?")


# Helper to load partials
def load_partial(name)
  apply File.join(__dir__, 'partials', "#{name}.rb")
end

# 2. Load Partials
load_partial 'gems' 

load_partial