# Rails 8 Application Template - Setup & Features

This project was initialized using a custom Rails 8 template designed to accelerate development by scaffolding a modern testing suite, authentication system, and UI foundations.

## 🚀 Quick Start

To generate a new application using this template:

```bash
rails new my_app_name -m template.rb --css=tailwind
```

> **Note:** The flag `--css=tailwind` is **required** as the generated views utilize Tailwind CSS utility classes.

After the installation completes:

```bash
cd my_app_name
bin/dev
```

## ✨ Features Overview

### 1. 🛠 Technology Stack
*   **Ruby on Rails 8.0+**
*   **Tailwind CSS** (Styling)
*   **RSpec** (Testing Framework)
*   **FactoryBot** (Test Data)
*   **Rubocop** (Linting & Formatting)

### 2. 🔐 Authentication System
The template generates a robust authentication system based on the native Rails 8 `generate authentication` command, with several enhancements:

*   **Native Sessions:** Uses Rails 8 `Current` attributes and Session handling.
*   **Registration:** A fully functional `RegistrationsController` and view for new user sign-ups (not included in default Rails 8).
*   **Email Verification (Optional):**
    *   Database schema for `confirmed_at` and `confirmation_token`.
    *   `UserMailer` configured to send confirmation links.
    *   Middleware logic to restrict access to unconfirmed users.
*   **Helper Methods:**
    *   `current_user` available in controllers and views.
    *   `allow_unauthenticated_access` macro for controllers.

### 3. 🎨 UI & Layout
A polished, responsive layout is pre-configured:
*   **Application Layout:** Includes a sticky footer and responsive container.
*   **Navigation Menu:** A dynamic `_menu.html.erb` partial that automatically toggles links based on the user's sign-in state.
*   **Flash Messages:** A `_flash.html.erb` partial that styles success (notice) and error (alert) messages using Tailwind colors.
*   **Landing Page:** A `HomeController` with a styled welcome index.

### 4. 📧 Email Testing
*   **Letter Opener Web:** configured for the Development environment.
*   Emails sent by the application (like confirmation links) are intercepted and viewable in the browser.
*   **Access:** Visit `http://localhost:3000/letter_opener`.

### 5. 🧪 Testing & Quality
The standard Minitest suite has been replaced with the RSpec ecosystem:

*   **RSpec:** Configured with `documentation` format by default.
*   **FactoryBot:** Integrated into `rails_helper` for easy data creation.
*   **Guard:** Watches file changes and runs tests automatically in the background.
*   **Rubocop:** Configured with "Omakase" Rails styling rules to enforce code quality.

---

## 📖 How to Use

### Managing Authentication
By default, controllers require authentication. To allow public access to a specific controller or action:

```ruby
class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
  # ...
end
```

To access the currently logged-in user in views or controllers:

```erb
<% if current_user %>
  Hello, <%= current_user.email_address %>
<% end %>
```

### Running Tests
You can run the full test suite manually:

```bash
bundle exec rspec
```

Or run **Guard** to automatically run tests as you save files (highly recommended):

```bash
bundle exec guard
```

### Code Formatting
To check for style violations:

```bash
bundle exec rubocop
```

To automatically fix simple style violations:

```bash
bundle exec rubocop -a
```

### Checking Emails (Development)
1. Register a new user or trigger an action that sends an email.
2. Navigate to `http://localhost:3000/letter_opener`.
3. Click the email to view the content and click any links (e.g., "Confirm Account").

---

## 📂 Key Generated Files

*   `app/controllers/registrations_controller.rb`: Handles user signup.
*   `app/views/shared/_menu.html.erb`: The main navigation bar.
*   `spec/rails_helper.rb`: Main RSpec configuration.
*   `.rubocop.yml`: Linting rules.
*   `config/environments/development.rb`: Configured for Letter Opener.