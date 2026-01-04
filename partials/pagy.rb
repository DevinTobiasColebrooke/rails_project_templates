def setup_pagy
  puts "📄  Configuring Pagination (Pagy)..."

  # 1. Add Gem
  gem 'pagy', '~> 43.2'

  if @api_only
    inject_into_file 'app/controllers/application_controller.rb', after: "class ApplicationController < ActionController::API\n" do
      "  include Pagy::Method\n"
    end
  else
    inject_into_file 'app/controllers/application_controller.rb', after: "class ApplicationController < ActionController::Base\n" do
      "  include Pagy::Method\n"
    end
  end

  # 3. CSS Styles
  # Only generate CSS if we are NOT in API mode, or if the file already exists.
  return if @api_only && !File.exist?("app/assets/stylesheets/application.tailwind.css")

  pagy_styles = <<~CSS
    
    /* Pagy Pagination Styles */
    .pagy {
      @apply flex space-x-1 font-semibold text-sm text-gray-500;
      a:not(.gap) {
        @apply block rounded-lg px-3 py-1 bg-gray-200;
        &:hover {
          @apply bg-gray-300;
        }
        &:not([href]) { /* disabled links */
          @apply text-gray-300 bg-gray-100 cursor-default;
        }
        &.current {
          @apply text-white bg-gray-400;
        }
      }
      label {
        @apply inline-block whitespace-nowrap bg-gray-200 rounded-lg px-3 py-0.5;
        input {
          @apply bg-gray-100 border-none rounded-md;
        }
      }
    }
  CSS

  target_css = "app/assets/stylesheets/application.tailwind.css"
  
  if File.exist?(target_css)
    append_to_file target_css, pagy_styles
  else
    # Fallback: create it if missing (Only happens in non-API mode due to guard clause above)
    create_file target_css, "@import \"tailwindcss\";\n#{pagy_styles}"
  end
end