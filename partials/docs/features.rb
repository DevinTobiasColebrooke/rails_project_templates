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

  # 2. Storage & Rich Text
  if @install_active_storage || @install_action_text
    content = "# Content & Storage\n\n"
    
    if @install_active_storage
      content += <<~MARKDOWN
        ## Active Storage (File Uploads)
        
        ### Setup
        1. **Configuration**: Edit `config/storage.yml` to define your storage service (local, azure, gcs, etc).
        2. **Enable**: Update `config/environments/production.rb` to set `config.active_storage.service` to your chosen provider.

        ### Usage
        ```ruby
        class User < ApplicationRecord
          has_one_attached :avatar
        end
        ```
      MARKDOWN
    end

    if @install_action_text
      content += <<~MARKDOWN

        ## Action Text (Rich Text)
        
        ### Usage
        Adds a Trix editor to your forms.
        
        **Model:**
        ```ruby
        class Article < ApplicationRecord
          has_rich_text :content
        end
        ```

        **View (Form):**
        ```erb
        <%= form.rich_text_area :content %>
        ```
        
        **View (Display):**
        ```erb
        <%= @article.content %>
        ```
      MARKDOWN
    end

    create_file "docs/content_and_storage.md", content
  end

  # 3. AI & Data
  if @install_gemini || @install_local || @install_vector_db || @install_searxng
    
    ai_content = "## AI Providers\n"
    ai_content += "- **Gemini**: Use `GoogleGeminiService`. Requires `google: gemini_key` in credentials.\n" if @install_gemini
    ai_content += "- **Local Llama**: Use `LocalLlmService`. Connects to Windows host on port 9090. See `config/initializers/ai_config.rb`.\n" if @install_local
    ai_content += "- **SearXNG**: Use `WebSearchService`. Connects to `ENV['SEARXNG_URL']` (Default: localhost:8888).\n" if @install_searxng
    
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
    
    if @install_searxng
      ai_content += <<~MARKDOWN

        ## Web Search Tools
        - **Service**: `app/services/web_search_service.rb`
        - **Tool Wrapper**: `app/models/tools/searxng_search_tool.rb`
        - **Dependency**: `ferrum` gem (Headless Chrome) is installed for scraping content.
      MARKDOWN
    end

    create_file "docs/ai_and_data.md", <<~MARKDOWN
      # AI & Data Services

      ## Configuration
      Check `config/initializers/ai_config.rb` for settings regarding IP detection (WSL/Windows) and API keys.

      #{ai_content}
    MARKDOWN
  end

  # 4. Stripe
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

  # 5. UI
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

  # 6. Ops
  if @install_ops
    create_file "docs/operations.md", <<~MARKDOWN
      # Operations & Observability

      - **Rack Attack**: Configured in `config/initializers/rack_attack.rb`.
      - **Bullet**: Checks for N+1 queries in Development.
      - **Ahoy**: Analytics enabled. Check `Ahoy::Visit` and `Ahoy::Event`.
    MARKDOWN
  end
  
  # 7. Pagination (Pagy)
  if @install_pagy
    create_file "docs/pagination.md", <<~MARKDOWN
      # Pagination (Pagy)

      ## Quick Start
      Use `pagy` in controllers and `<%== @pagy.nav %>` in views.
      See `config/initializers/pagy.rb` for configuration.
    MARKDOWN
  end
end