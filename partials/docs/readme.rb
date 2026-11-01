# partials/docs/readme.rb

def setup_docs_readme
  puts '    ...updating README.md and creating Docs TOC'

  # 1. Generate Link List for Docs
  links = []
  links << '- [Project Foundation](./project_foundation/)'
  links << '- [Authentication](./authentication.md)' if @install_auth
  links << '- [AI & Data](./ai_and_data.md)' if @install_gemini || @install_local || @install_vector_db
  links << '- [Content & Storage](./content_and_storage.md)' if @install_active_storage || @install_action_text
  links << '- [Pagination](./pagination.md)' if @install_pagy
  links << '- [Payments](./payments.md)' if @install_stripe
  links << '- [UI & Themes](./ui_and_themes.md)' if @install_ui
  links << '- [Operations](./operations.md)' if @install_ops

  # 2. Create docs/README.md (Table of Contents for the docs folder)
  create_file 'docs/README.md', <<~MARKDOWN
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

  # Active Storage credentials placeholder removed (AWS support removed)

  creds << 'data_gov_key: "YOUR_DATA_GOV_KEY"' if @install_api

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
      Use the provided `start_ai_servers.bat` (or `start_recon_stack.bat` if using Recon) script in the root directory.

      **Option B: Manual**
      - **Chat Server**: Port 9090
      - **Embeddings**: Port 9091
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

    #{config_section.empty? ? 'No specific configuration required.' : config_section.join("\n")}

    ## 📚 Documentation

    Detailed guides are located in the `docs/` folder:

    #{links.map { |l| l.gsub('](./', '](docs/') }.join("\n")}

    ## ✨ Features Enabled

    - **Rails 8**: Propshaft, importmaps, and Tailwind CSS.
    #{@install_auth ? '- **Authentication**: Native Rails auth with custom controllers.' : ''}
    #{@install_stripe ? '- **Payments**: Stripe Checkout & Webhooks integration.' : ''}
    #{@install_action_text ? '- **Content**: Action Text (Rich Text) enabled.' : ''}
    #{if @install_gemini || @install_local
        "- **AI**: Integration with #{@install_local ? 'Local LLMs' : ''} #{@install_gemini ? 'Google Gemini' : ''}."
      else
        ''
      end}
    #{@install_vector_db ? '- **Vector DB**: pgvector + Neighbor for semantic search.' : ''}
    #{@install_ops ? '- **Ops**: Rack Attack, Bullet, and Ahoy analytics.' : ''}
  MARKDOWN

  # 4. Create SETUP.md
  create_file 'SETUP.md', <<~MARKDOWN
    # Rails 8 Super Template - Setup & Documentation

    This project was initialized using a comprehensive Rails 8 template designed to act as a production-ready starter kit. It scaffolds authentication, payments, AI integration, observability, and content management foundations out of the box.

    ## 🚀 Quick Start

    **Option A: Using the Windows Batch Script (Recommended for WSL)**
    If you are on Windows using WSL, use the provided `create_rails_app.bat` script. This handles IP detection, Postgres startup, and VS Code launching automatically.

    **Option B: Manual Generation**
    To generate a new application manually using the template:

    ```bash
    rails new my_app_name -m template.rb -d postgresql --css=tailwind
    ```

    > **Note:** The flags `-d postgresql` and `--css=tailwind` are **required**.

    After the installation completes:

    ```bash
    cd my_app_name
    bin/dev
    ```

    ---

    ## ⚠️ Post-Installation & Configuration

    This template automates the code generation, but you must manually configure secrets and external services.

    ### 1. 🔑 Configure Credentials & Secrets
    Run the credentials editor to set up API keys for the features you selected. We use the `--wait` flag so the terminal waits for you to close the VS Code tab before saving.

    ```bash
    EDITOR="code --wait" bin/rails credentials:edit
    ```

    Depending on your choices, add the following keys:

    ```yaml
    # 1. AI Services
    google:
      gemini_key: "YOUR_GEMINI_API_KEY"

    # 2. Payments (Stripe)
    stripe:
      publishable_key: "pk_test_..."
      secret_key: "sk_test_..."
      signing_secret: "whsec_..." # For Webhooks

    # 3. External APIs
    data_gov_key: "YOUR_DATA_GOV_KEY"
    ```

    ### 2. 🦙 Start Local AI Server (If using Local Llama)
    If you selected **Local AI**, the Rails app connects to a server on your Windows Host via a generic "default" model name.

    **Option A: Automated (Recommended)**
    Use the provided `start_ai_servers.bat` script which launches both the Instruct and Embedding servers in a split-pane Windows Terminal.
    1.  Open `start_ai_servers.bat` in a text editor.
    2.  Update `LLAMA_DIR` to point to the folder containing your `llama-server.exe`.
    3.  Run the script: `.\\start_ai_servers.bat`

    **Option B: Manual**
    1.  Open PowerShell on **Windows**.
    2.  Run the **Instruct/Chat** server on port **9090**:
        ```powershell
        ./llama-server.exe -m path/to/model.gguf --port 9090 --host 0.0.0.0
        ```
    3.  Run the **Embedding** server on port **9091** (Required if using Vector DB):
        ```powershell
        ./llama-server.exe -m path/to/nomic-embed.gguf --embedding --port 9091 --host 0.0.0.0
        ```

    ### 3. 💳 Testing Stripe Webhooks
    To test payments locally, you need the Stripe CLI forwarding events to your app.

    ```bash
    stripe listen --forward-to localhost:3000/webhooks/stripe
    ```

    ---

    ## 📚 Project Documentation

    Upon generation, a `docs/` folder is created within your application containing detailed guides specific to the features you enabled:

    *   **`docs/project_foundation/`**: Architecture diagrams and schema plans.
    *   **`docs/authentication.md`**: User auth and session details.
    *   **`docs/ai_and_data.md`**: Configuration for Gemini, Local Llama, and Vector DB.
    *   **`docs/payments.md`**: Stripe setup and webhook handling.
    *   **`docs/ui_and_themes.md`**: How to use the theming system.

    ---

    ## ✨ Features Overview

    ### 🤖 AI & Data
    *   **Service Layer:** Pre-built services for **Google Gemini** and **Local Llama** (WSL-bridge).
    *   **Vector Database:** `pgvector` + `neighbor` gem configuration for semantic search.
    *   **Prompt Management:** Store system prompts in `config/prompts.yml` instead of hardcoding them.
    *   **API Generator:** Generic `ApplicationApiService` pattern with a Data.gov example implementation.

    ### 💰 Commerce (Stripe)
    *   **Checkout:** Controllers and Views for one-time payments.
    *   **Webhooks:** Secure webhook verification and event handling logic in `WebhooksController`.
    *   **UI:** Pre-styled "Buy Button" partials.

    ### 🎨 Content & UI
    *   **Themes:** A full design system installed at `app/assets/tailwind/design_system.css` (brand tokens + `.ds-*` components).
    *   **Admin Panel:** A dedicated `Admin::BaseController` and dashboard layout, distinct from the main app.
    *   **Rich Text:** ActionText (Trix) installed with Tailwind typography fixes.
    *   **SEO:** `MetaTags` and `SitemapGenerator` pre-configured.

    ### 🛡️ Ops & Observability
    *   **Rack Attack:** Throttling and rate-limiting middleware configured in `config/initializers/rack_attack.rb`.
    *   **Bullet:** Detects N+1 queries in development.
    *   **Ahoy:** First-party analytics for tracking visits and events.
    *   **Scenic:** SQL View management support.
    *   **PgQuery:** SQL parsing utilities for performance analysis.

    ---

    ## 📖 How to Use

    ### 🧠 Knowledge Base (Vector Search)
    If you enabled the Vector DB, you have a `Document` model ready for semantic search.

    ```ruby
    # 1. Create a document (Embedding is generated automatically via service)
    doc = Document.create(content: "Rails 8 includes a new authentication generator.")

    # 2. Search semantically
    results = Document.semantic_search("What is new in the framework?")
    puts results.first.content
    ```

    ### 🎨 Changing Themes
    This app was generated with a complete design system installed at
    `app/assets/tailwind/design_system.css` and imported from
    `app/assets/tailwind/application.css`. It ships with a 19-token color
    contract (surfaces, borders, text, actions, accents), typography, radii,
    motion, and `.ds-*` component recipes. Use the `brand-*` utilities
    (`bg-brand-surface`, `text-brand-action`, ...) everywhere.

    Flip to the counterpart light/dark palette with `data-theme="light"` or
    `data-theme="dark"` on the `<html>` element. The full design brief lives in
    `docs/design_system.md` and the machine-readable spec in
    `docs/design_system.json`.

    ### 🔌 Consuming APIs
    Use the generated service pattern for clean external data fetching:

    ```ruby
    # app/services/data_gov_service.rb
    service = DataGovService.new
    schools = service.search_schools(state: 'NY')
    ```

    ### 🔍 SEO Helper
    In your views/controllers, set metadata easily:

    ```ruby
    # In a controller
    def show
      @product = Product.find(params[:id])
      set_meta_tags title: @product.name,
                    description: @product.description,
                    keywords: 'rails, ruby, template'
    end
    ```

    ---

    ## 📂 Key Generated Files

    | File Path | Description |
    | :--- | :--- |
    | `config/initializers/ai_config.rb` | AI Settings & WSL IP Detection |
    | `app/assets/tailwind/design_system.css` | Design system tokens, `brand-*` utilities, and `.ds-*` components |
    | `docs/design_system.md` | Full design brief for the installed design system |
    | `config/prompts.yml` | Centralized AI Prompt storage |
    | `config/initializers/rack_attack.rb` | Rate limiting configuration |
    | `app/controllers/admin/*` | Custom Admin panel logic |
    | `app/services/embedding_service.rb` | routing logic for Local vs Cloud embeddings |
    | `app/models/document.rb` | Vector-enabled model |
    | `app/views/checkouts/*` | Stripe payment success/cancel pages |
  MARKDOWN

  # 5. Append to existing README.md

  append_to_file 'README.md', readme_append
end
