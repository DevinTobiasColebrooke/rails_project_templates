# partials/docs/readme.rb

def setup_docs_readme
  puts "    ...updating README.md and creating Docs TOC"

  # 1. Generate Link List for Docs
  links = []
  links << "- [Project Foundation](./project_foundation/)"
  links << "- [Authentication](./authentication.md)" if @install_auth
  links << "- [AI & Data](./ai_and_data.md)" if @install_gemini || @install_local || @install_vector_db
  links << "- [Pagination](./pagination.md)" if @install_pagy
  links << "- [Payments](./payments.md)" if @install_stripe
  links << "- [UI & Themes](./ui_and_themes.md)" if @install_ui
  links << "- [Operations](./operations.md)" if @install_ops

  # 2. Create docs/README.md (Table of Contents for the docs folder)
  create_file "docs/README.md", <<~MARKDOWN
    # Project Documentation

    This `docs/` folder contains specific setup and usage instructions for the features enabled in this application.

    ## Table of Contents
    #{links.join("\n")}
  MARKDOWN

  # 3. Prepare content to append to the Root README.md
  
  # --- Build Configuration Section ---
  config_section = []
  
  # A. Credentials
  creds = []
  creds << "google:\n    gemini_key: \"YOUR_GEMINI_API_KEY\"" if @install_gemini
  
  if @install_stripe
    creds << <<~YAML.strip
      stripe:
          publishable_key: "pk_test_..."
          secret_key: "sk_test_..."
          signing_secret: "whsec_..." # For Webhooks
    YAML
  end
  
  creds << "data_gov_key: \"YOUR_DATA_GOV_KEY\"" if @install_api
  
  if creds.any?
    config_section << <<~MARKDOWN
      ### 1. 🔑 Configure Credentials
      Run the credentials editor to set up API keys for the features you selected.

      ```bash
      EDITOR="code --wait" bin/rails credentials:edit
      ```

      Add the following keys to the encrypted file:

      ```yaml
      #{creds.join("\n")}
      ```
    MARKDOWN
  end

  # B. Local AI
  if @install_local
    step_num = creds.any? ? 2 : 1
    config_section << <<~MARKDOWN
      ### #{step_num}. 🦙 Start Local AI Server
      This application is configured to connect to a Local LLM running on your Windows Host (via WSL networking).

      **Option A: Automated (Recommended)**
      Use the provided `start_ai_servers.bat` script in the root directory of the project (run from Windows).

      **Option B: Manual**
      - **Chat Server**: Port 8080
      - **Embeddings**: Port 8081
    MARKDOWN
  end

  # C. Stripe Webhooks
  if @install_stripe
    step_num = 1
    step_num += 1 if creds.any?
    step_num += 1 if @install_local
    
    config_section << <<~MARKDOWN
      ### #{step_num}. 💳 Testing Stripe Webhooks
      To test payments locally, use the Stripe CLI to forward events:

      ```bash
      stripe listen --forward-to localhost:3000/webhooks/stripe
      ```
    MARKDOWN
  end

  # --- Text to Append ---
  readme_append = <<~MARKDOWN

    ---
    
    ## ⚠️ Post-Installation & Configuration
    
    #{config_section.empty? ? "No specific configuration required." : config_section.join("\n")}

    ## 📚 Documentation
    
    Detailed guides are located in the `docs/` folder:
    
    #{links.map { |l| l.gsub("](./", "](docs/") }.join("\n")}
    
    ## ✨ Features Enabled
    
    - **Rails 8**: Propshaft, importmaps, and Tailwind CSS.
    - **Pagination**: Pagy (High performance pagination).
    #{@install_auth ? "- **Authentication**: Native Rails auth with custom controllers." : ""}
    #{@install_stripe ? "- **Payments**: Stripe Checkout & Webhooks integration." : ""}
    #{@install_gemini || @install_local ? "- **AI**: Integration with #{@install_local ? 'Local LLMs' : ''} #{@install_gemini ? 'Google Gemini' : ''}." : ""}
    #{@install_vector_db ? "- **Vector DB**: pgvector + Neighbor for semantic search." : ""}
    #{@install_ops ? "- **Ops**: Rack Attack, Bullet, and Ahoy analytics." : ""}
  MARKDOWN

  # 4. Append to existing README.md
  append_to_file "README.md", readme_append
end