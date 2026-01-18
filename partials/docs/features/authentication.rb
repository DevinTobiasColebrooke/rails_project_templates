if @install_auth
  create_file 'docs/authentication.md', <<~MARKDOWN
    # Authentication System

    ## Overview
    This application uses the native authentication system introduced in Rails 8. It provides a secure, session-based authentication flow without relying on heavy external gems like Devise. It is fully integrated into the application structure, giving you full control over the logic and views.

    ## Key Components

    ### Models
    - **`User`** (`app/models/user.rb`): The core identity model. Handles password security using `has_secure_password` (BCrypt).
    - **`Session`** (`app/models/session.rb`): Represents a logged-in device/browser. Links a `User` to a browser session.
    - **`Current`** (`app/models/current.rb`): A thread-local global attribute accessor (via `ActiveSupport::CurrentAttributes`) to access `Current.user` and `Current.session` anywhere in the app.

    ### Controllers
    - **`SessionsController`** (`app/controllers/sessions_controller.rb`): Handles sign-in (creating a session) and sign-out (destroying a session).
    - **`RegistrationsController`** (`app/controllers/registrations_controller.rb`): Handles new user sign-ups.
    - **`PasswordsController`** (`app/controllers/passwords_controller.rb`): Handles password reset requests (forgot password flow).
    - **`Concerns::Authentication`** (`app/controllers/concerns/authentication.rb`): Included in `ApplicationController`. It manages session restoration and provides the `allow_unauthenticated_access` helper.

    ### Views
    - `app/views/sessions/`: Login form.
    - `app/views/registrations/`: Sign-up form.
    - `app/views/passwords/`: Reset password forms.

    ## Database Schema
    - **`users` table**: Stores `email_address` (indexed, unique) and `password_digest`.
    - **`sessions` table**: Stores `user_id`, `ip_address`, and `user_agent`.

    ## Usage

    ### Protecting Resources
    By default, **all** controllers require authentication because `ApplicationController` includes the authentication concern.

    To make a specific action public:
    ```ruby
    class PagesController < ApplicationController
      allow_unauthenticated_access only: [:home, :privacy]
    end
    ```

    ### Accessing the Current User
    In controllers and views:
    ```ruby
    if authenticated?
      <h1>Welcome, <%= current_user.email_address %></h1>
    end
    ```

    ### Email Verification
    #{@install_verify ? 'Enabled. When a user signs up, a verification email is sent via `UserMailer`. Users must verify their email before accessing restricted parts of the application.' : 'Disabled by default.'}

    ## Customization
    - **Adding Fields**: To add more user fields (e.g., name, username), add a migration to the `users` table and update `app/controllers/registrations_controller.rb` to permit the new parameters.
    - **Password Rules**: Validation rules for passwords can be found in `app/models/user.rb`.
  MARKDOWN
end
