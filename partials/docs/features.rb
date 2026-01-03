# partials/docs/features.rb

def setup_docs_features
  puts "    ...generating Feature specific documentation"

  # 1. Authentication
  if @install_auth
    create_file "docs/authentication.md", <<~MARKDOWN
      # Authentication System

      ## Overview
      This app uses Rails 8 native authentication with a custom `RegistrationsController`.

      ## Usage
      - **Controllers**: By default, all controllers require authentication.
        To make a page public:
        ```ruby
        allow_unauthenticated_access only: [:index]
        ```
      - **Helpers**: Use `current_user` in views and controllers.
      
      ## Configuration
      - **Email Verification**: #{@install_verify ? "Enabled. Check `UserMailer`." : "Disabled."}
      - **Sessions**: Managed via `Current.session` and `Session` model.
    MARKDOWN
  end

  # 2. AI & Data
  if @install_gemini || @install_local || @install_vector_db
    
    ai_content = "## AI Providers\n"
    ai_content += "- **Gemini**: Use `GoogleGeminiService`. Requires `google: gemini_key` in credentials.\n" if @install_gemini
    ai_content += "- **Local Llama**: Use `LocalLlmService`. Connects to Windows host on port 8080. See `config/initializers/ai_config.rb`.\n" if @install_local
    
    if @install_vector_db
      ai_content += <<~MARKDOWN

        ## Vector Database
        - **Model**: `Document` (content, embedding, metadata).
        - **Usage**: `Document.semantic_search("query")`.
        - **Embeddings**: Auto-generated via `EmbeddingService`.
      MARKDOWN
    end

    if @install_prompts
      ai_content += <<~MARKDOWN

        ## Prompt Management
        - Edit prompts in `config/prompts.yml`.
        - Access via `Prompt.get('key')`.
      MARKDOWN
    end

    create_file "docs/ai_and_data.md", <<~MARKDOWN
      # AI & Data Services

      ## Configuration
      Check `config/initializers/ai_config.rb` for settings regarding IP detection (WSL/Windows) and API keys.

      #{ai_content}
    MARKDOWN
  end

  # 3. Stripe
  if @install_stripe
    create_file "docs/payments.md", <<~MARKDOWN
      # Stripe Payments

      ## Setup
      1. Add keys to `credentials.yml.enc`:
         ```yaml
         stripe:
           publishable_key: ...
           secret_key: ...
           signing_secret: ...
         ```
      2. **Webhooks**: Run `stripe listen --forward-to localhost:3000/webhooks/stripe`

      ## Architecture
      - `CheckoutsController`: Handles creating sessions.
      - `WebhooksController`: Handles `checkout.session.completed`.
    MARKDOWN
  end

  # 4. UI
  if @install_ui
    create_file "docs/ui_and_themes.md", <<~MARKDOWN
      # UI & Theming

      ## Themes
      Edit `config/themes.yml` to change color palettes without touching CSS.
      
      ## Admin Panel
      #{@install_admin ? "Access via `/admin`. Logic in `app/controllers/admin/`." : "Not installed."}
      
      ## Components
      - **Flash**: `app/views/shared/_flash.html.erb`
      - **Menu**: `app/views/shared/_menu.html.erb`
    MARKDOWN
  end

  # 5. Ops
  if @install_ops
    create_file "docs/operations.md", <<~MARKDOWN
      # Operations & Observability

      - **Rack Attack**: Configured in `config/initializers/rack_attack.rb`.
      - **Bullet**: Checks for N+1 queries in Development.
      - **Ahoy**: Analytics enabled. Check `Ahoy::Visit` and `Ahoy::Event`.
    MARKDOWN
  end
end