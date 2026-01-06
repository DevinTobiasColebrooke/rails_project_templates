# 1. Configuration Wizard
puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

# Helper to check ENV first, then ask
def fetch_config(prompt, env_var)
  if ENV[env_var].present?
    puts "    🔑  Found value for #{env_var} from script."
    ENV[env_var]
  else
    ask(prompt)
  end
end

# Detect API Mode
@api_only = options[:api]

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


puts "\n🧱  Content & Data"
@install_api       = yes?("    Add API Services (Data.gov example)?")
if @install_api
  @data_gov_key = fetch_config("    🔑  (Optional) Enter Data.gov API Key:", "TEMPLATE_DATA_GOV")
end

# Pagy is now auto-included as standard
@install_pagy = true
puts "    -> 📄 Pagination (Pagy) auto-enabled."

puts "\n💳  Payments"
@install_stripe = yes?("    Add Stripe Payments?")
if @install_stripe
  puts "    🔑  Stripe Configuration:"
  @stripe_publishable = fetch_config("        Publishable Key:", "TEMPLATE_STRIPE_PUB")
  @stripe_secret      = fetch_config("        Secret Key:", "TEMPLATE_STRIPE_SEC")
  @stripe_signing     = fetch_config("        Signing Secret (Webhook):", "TEMPLATE_STRIPE_SIGN")
end

puts "\n🤖  AI & Research Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
if @install_gemini
  @gemini_key = fetch_config("    🔑  (Optional) Enter Gemini API Key:", "TEMPLATE_GEMINI")
end

@install_recon  = yes?("    Add Deep Research Agent (Recon)?")
if @install_recon
  puts "    🔑  Google Custom Search Credentials (for Recon):"
  @google_search_key = fetch_config("        Search API Key:", "TEMPLATE_GOOGLE_SEARCH_KEY")
  @google_search_id  = fetch_config("        Search Engine ID:", "TEMPLATE_GOOGLE_SEARCH_CX")
end

if @install_recon
  puts "    -> 🕵️‍♂️  Recon Agent selected."
  puts "    -> 📦 Auto-enabling Local AI and Vector DB (Required dependencies)."
  @install_local = true
  @install_vector_db = true
else
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

# 2. Load Partials 
load_partial 'gems' 
load_partial 'testing'
load_partial 'performance'
load_partial 'ui'
load_partial 'chat_ui' 
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

# 3. Execute Setup 
after_bundle do
  # 1. Foundation & Config
  setup_testing
  setup_performance if @install_ops

  # 2. Core Identity (Users) - MUST run before features that reference users (like Chat UI)
  # This ensures CreateUsers migration is generated before CreateConversations
  setup_authentication if @install_auth

  # 3. UI Framework
  setup_ui_layout if @install_ui
  
  # 4. Features dependent on UI/Auth
  if @install_chat_ui
    setup_chat_ui
  end

  setup_themes_and_admin if @install_ui || @install_admin 

  # 5. Standalone Features
  setup_api_generator if @install_api
  setup_seo if @install_seo
  setup_pagy if @install_pagy 
  setup_stripe if @install_stripe

  # 6. Data & AI
  setup_vector_db if @install_vector_db
  
  if @install_gemini || @install_local
    setup_ai_configuration
    setup_ai_services
  end

  setup_recon if @install_recon
  
  setup_prompt_management if @install_prompts

  # 7. Documentation & Cleanup
  setup_docs
  setup_finalize
end