# 1. Configuration Wizard
puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

# Detect API Mode
# We check the options hash passed to the generator instead of Rails.configuration
@api_only = options[:api]

if @api_only
  puts "🤖  API Mode Detected."
  puts "    Skipping UI, Admin, SEO, and Browser-Auth prompts."
  
  @install_ui = false
  @install_chat_ui = false
  @install_admin = false
  @install_seo = false
  @install_auth = false # Native Rails 8 auth is session/browser based
else
  @install_ui    = yes?("🎨  Add UI (Tailwind, Flash, Menu, Custom Themes)?")
  @install_chat_ui = yes?("    💬  Add AI Chat UI (Conversational Interface)?")
  @install_admin = yes?("👑  Add Custom Admin Panel?")
  @install_auth  = yes?("🔐  Add Authentication?")
  if @install_auth
    @install_verify = yes?("    📧  Add Email Verification?")
  end
  # Rich Text removed as requested
  @install_seo       = yes?("    Add SEO Tools (MetaTags, Sitemap)?")
end


puts "\n🧱  Content & Data"
@install_api       = yes?("    Add API Services (Data.gov example)?")

# Pagy is now auto-included as standard
@install_pagy = true
puts "    -> 📄 Pagination (Pagy) auto-enabled."

puts "\n💳  Payments"
@install_stripe = yes?("    Add Stripe Payments?")

puts "\n🤖  AI & Research Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
@install_recon  = yes?("    Add Deep Research Agent (Recon)?")

if @install_recon
  puts "    -> 🕵️‍♂️  Recon Agent selected."
  puts "    -> 📦 Auto-enabling Local AI and Vector DB (Required dependencies)."
  @install_local = true
  @install_vector_db = true
else
  # Only prompt for these if Recon didn't auto-enable them
  @install_local = yes?("    Add Local AI (Llama via Windows/WSL)?")
  
  puts "\n🧠  Knowledge Base"
  @install_vector_db = yes?("    Add Vector Database (pgvector + Neighbor)?")
end

if @install_gemini || @install_local || @install_recon
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

# 2. Load Partials (Defines methods or adds gems)
load_partial 'gems' 
load_partial 'testing'
load_partial 'performance'
load_partial 'ui'
load_partial 'chat_ui' # New Loader
load_partial 'themes'
load_partial 'auth'
load_partial 'api_client'
load_partial 'seo'
load_partial 'pagy'
load_partial 'stripe'
load_partial 'vector_db'
load_partial 'ai'
load_partial 'recon'
load_partial 'prompts'
load_partial 'docs'
load_partial 'finalize'

# 3. Execute Setup (Runs after bundle install)
after_bundle do
  # Testing & Ops
  setup_testing
  setup_performance if @install_ops

  # UI & Admin (Skipped in API mode)
  setup_ui_layout if @install_ui
  
  if @install_chat_ui
    setup_chat_ui
  end

  setup_themes_and_admin if @install_ui || @install_admin 

  # Authentication
  setup_authentication if @install_auth

  # Features
  setup_api_generator if @install_api
  setup_seo if @install_seo
  setup_pagy if @install_pagy # Always runs now, but handles API logic inside
  setup_stripe if @install_stripe

  # Data & AI
  setup_vector_db if @install_vector_db
  
  if @install_gemini || @install_local
    setup_ai_configuration
    setup_ai_services
  end

  setup_recon if @install_recon
  
  setup_prompt_management if @install_prompts

  # Documentation
  setup_docs

  # Finalize
  setup_finalize
end