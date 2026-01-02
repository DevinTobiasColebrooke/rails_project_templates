# Rails 8 Application Template - Setup & Features

This project was initialized using a custom Rails 8 template designed to accelerate development by scaffolding a modern testing suite, authentication system, AI service integrations, and UI foundations.

## 🚀 Quick Start

**Option A: Using the Windows Batch Script (Recommended for WSL)**
If you are on Windows using WSL, use the provided `create_rails_app.bat` script. This handles IP detection and database startup automatically.

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

## ⚠️ Post-Installation & Manual Configuration

While the template automates 90% of the work, there are specific secrets and external tools you must configure manually depending on the options you selected during generation.

### 1. 🔑 Configure Credentials (If using Gemini AI)
If you selected **Google Gemini**, the application expects your API key to be encrypted in the Rails credentials file.

1.  Open the credentials editor:
    ```bash
    EDITOR="nano" bin/rails credentials:edit
    ```
2.  Add your key under a `google` key:
    ```yaml
    google:
      gemini_key: "YOUR_ACTUAL_API_KEY_HERE"
    ```
3.  Save and exit.

### 2. 🦙 Start Local AI Server (If using Local Llama)
If you selected **Local AI**, the Rails app expects to connect to a server running on your Windows Host.

1.  Open a PowerShell terminal on **Windows**.
2.  Navigate to your `llama-server.exe` directory.
3.  Run the server on port **8080** allowing external connections:
    ```powershell
    ./llama-server.exe -m path/to/your/model.gguf --port 8080 --host 0.0.0.0
    ```
4.  *(Optional)* If using RAG/Embeddings, run a second instance on port **8081**:
    ```powershell
    ./llama-server.exe -m path/to/your/model.gguf --embedding --port 8081 --host 0.0.0.0
    ```

### 3. ⚙️ Verify RSpec Configuration
Occasionally, the template injection into `config/application.rb` may fail if the file structure varies. Open `config/application.rb` and ensure this block exists inside `class Application < Rails::Application`:

```ruby
config.generators do |g|
  g.test_framework :rspec,
    fixtures: true,
    view_specs: false,
    helper_specs: false,
    routing_specs: false,
    request_specs: true
  g.fixture_replacement :factory_bot, dir: "spec/factories"
end
```

---

## ✨ Features Overview

### 1. 🤖 AI Integration (New)
Depending on your selection, you have ready-to-use Service classes in `app/services/`:
*   **Gemini:** `GoogleGeminiService` for connecting to Google's API.
*   **Local LLM:** `LocalLlmService` configured to talk to your Windows host from inside WSL (handles IP resolution automatically).
*   **RAG Tools:** Setup for `pgvector` and `Ferrum` (headless browser) for building context-aware AI apps.

### 2. 🔐 Authentication System
*   **Native Sessions:** Uses Rails 8 `Current` attributes.
*   **Registration:** Fully functional `RegistrationsController`.
*   **Helper Methods:** `current_user` and `allow_unauthenticated_access`.

### 3. 🎨 UI & Layout
*   **Tailwind CSS:** Pre-configured with a build pipeline.
*   **Components:** Responsive Navigation Menu (`_menu.html.erb`) and Flash Messages (`_flash.html.erb`).

### 4. 🧪 Testing & Quality
*   **RSpec:** Replaces Minitest.
*   **FactoryBot:** Integrated for test data.
*   **Guard:** Auto-runs tests on file save (`bundle exec guard`).
*   **Rubocop:** Enforces code style.

---

## 📖 How to Use

### Testing AI Connections
To verify your AI service is working, open the Rails console:

```bash
bin/rails c
```

**For Gemini:**
```ruby
puts GoogleGeminiService.new.generate("Hello, how are you?")
```

**For Local Llama:**
```ruby
puts LocalLlmService.new.chat("Hello, are you running locally?")
```

### Managing Authentication
By default, controllers require authentication. To allow public access:

```ruby
class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
end
```

### Checking Emails (Development)
1. Trigger an action that sends an email (e.g., Sign Up).
2. Visit `http://localhost:3000/letter_opener` to view the email.

---

## 📂 Key Files

*   `config/initializers/ai_config.rb`: Handles API keys and WSL<->Windows IP detection.
*   `app/services/*`: Contains the AI service logic.
*   `app/controllers/registrations_controller.rb`: Handles user signup.
*   `spec/rails_helper.rb`: Main RSpec configuration.