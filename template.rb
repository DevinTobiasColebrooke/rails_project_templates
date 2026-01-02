# template.rb

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
end

# 2. Load Partials
load_partial 'gems' 

load_partial 'testing'
load_partial 'ui'
load_partial 'auth'
load_partial 'stripe' # <--- Added this
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