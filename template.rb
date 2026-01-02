puts "\n🚀 Rails 8 Master Template Wizard"
puts "========================================================"

# Instance variables (@) are accessible inside the 'apply' partials
@install_ui   = yes?("🎨  Add UI Structure (Tailwind, Home, Menu, Flash)?")
@install_auth = yes?("🔐  Add Authentication (Rails 8 Native + Registration)?")

if @install_auth
  @install_verify = yes?("    📧  Add Email Verification?")
end

puts "\n🤖  AI Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
@install_local  = yes?("    Add Local AI (Llama via Windows/WSL)?")
@install_rag    = yes?("    Add RAG Tools (Ferrum, Readability, Pgvector)?")

# Helper to load partials correctly relative to this file
def load_partial(name)
  apply File.join(__dir__, 'partials', "#{name}.rb")
end

# 2. Load Partials
# gems.rb executes immediately to define dependencies before bundling
load_partial 'gems' 

# These define methods to be called later
load_partial 'testing'
load_partial 'ui'
load_partial 'auth'
load_partial 'ai'
load_partial 'finalize'

# 3. Execution (After Bundle)
after_bundle do
  # Testing is standard
  setup_testing
  run "bundle exec guard init rspec"

  # Feature Setups
  setup_ui_layout if @install_ui
  setup_authentication if @install_auth
  
  if @install_gemini || @install_local || @install_rag
    setup_ai_configuration
    setup_ai_services
  end

  # Database & Cleanup
  setup_finalize
end