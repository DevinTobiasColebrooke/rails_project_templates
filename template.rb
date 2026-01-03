# 1. Configuration Wizard
puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

@install_ui   = yes?("🎨  Add UI Structure (Tailwind, Home, Menu, Flash)?")
@install_auth = yes?("🔐  Add Authentication (Rails 8 Native + Registration)?")

if @install_auth
  @install_verify = yes?("    📧  Add Email Verification?")
end

puts "\n💳  Payments"
@install_stripe = yes?("    Add Stripe Payments (Checkout + Webhooks)?")

puts "\n🤖  AI Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
@install_local  = yes?("    Add Local AI (Llama via Windows/WSL)?")
@install_rag    = yes?("    Add RAG Tools (Ferrum, Readability, Pgvector)?")

# Helper to load partials
def load_partial(name)
  apply File.join(__dir__, 'partials', "#{name}.rb")
end# template.rb

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
@install_rich_text = yes?("    Add Rich Text (ActionText)?")
@install_seo       = yes?("    Add SEO Tools (MetaTags, Sitemap)?")
@install_api       = yes?("    Add API Services (Data.gov example)?")
@install_prompts   = yes?("    Add Prompt Management System?")

puts "\n💳  Payments"
@install_stripe = yes?("    Add Stripe Payments?")

puts "\n🤖  AI Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
@install_local  = yes?("    Add Local AI (Llama via Windows/WSL)?")
@install_rag    = yes?("    Add RAG Tools (Ferrum, Readability, Pgvector)?")

puts "\n⚙️  Ops"
@install_ops = yes?("    Add Observability (RackAttack, Bullet, Ahoy, Scenic)?")


# Helper to load partials
def load_partial(name)
  apply File.join(__dir__, 'partials', "#{name}.rb")
end

# 2. Load Partials
load_partial 'gems' 

load_partial 'testing'
load_partial 'ui'
load_partial 'auth'
load_partial 'stripe'
load_partial 'ai'
load_partial 'rich_text'
load_partial 'seo'
load_partial 'performance'
load_partial 'themes'
load_partial 'prompts'
load_partial 'api_client'
load_partial 'finalize'

# 3. Execution (After Bundle)
after_bundle do
  setup_testing
  run "bundle exec guard init rspec"

  setup_ui_layout if @install_ui
  setup_themes_and_admin if @install_admin || @install_ui
  
  setup_rich_text if @install_rich_text
  setup_seo if @install_seo
  setup_performance if @install_ops
  setup_prompt_management if @install_prompts
  setup_api_generator if @install_api
  
  setup_authentication if @install_auth
  setup_stripe if @install_stripe
  
  if @install_gemini || @install_local || @install_rag
    setup_ai_configuration
    setup_ai_services
  end

  setup_finalize
end

# 2. Load Partials
load_partial 'gems' 

load_partial 'testing'
load_partial 'ui'
load_partial 'auth'
load_partial 'stripe'
load_partial 'ai'
load_partial 'finalize'

# 3. Execution (After Bundle)
after_bundle do
  setup_testing
  run "bundle exec guard init rspec"

  setup_ui_layout if @install_ui
  setup_authentication if @install_auth
  setup_stripe if @install_stripe # <--- Added this
  
  if @install_gemini || @install_local || @install_rag
    setup_ai_configuration
    setup_ai_services
  end

  setup_finalize
end