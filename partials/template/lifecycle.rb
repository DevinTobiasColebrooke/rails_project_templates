# 3. Execute Setup
after_bundle do
  # 1. Foundation & Config
  setup_testing
  setup_performance if @install_ops

  # 2. Core Identity (Users) - MUST run before features that reference users (like Chat UI)
  setup_authentication if @install_auth

  # 3. UI Framework & Admin
  # Refactored: UI scaffolding is now handled within setup_themes_and_admin
  setup_themes_and_admin if @install_ui || @install_admin

  # 4. Features dependent on UI/Auth
  setup_chat_ui if @install_chat_ui

  # 5. Standalone Features
  setup_active_storage if @install_active_storage
  setup_action_text if @install_action_text
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
  setup_agents
  setup_docs
  setup_finalize
end
