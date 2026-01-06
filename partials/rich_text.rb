def setup_action_text
  puts "📝  Configuring Action Text (Rich Text)..."

  # 1. Install Action Text
  # This installs the JS dependencies, creates migrations, and adds the Trix CSS
  run "bin/rails action_text:install"

  # 2. Fix Trix CSS for Tailwind (Optional but often needed)
  # Trix styles can sometimes conflict or look plain in Tailwind. 
  # We ensure the CSS is imported in the application layout or CSS file.
  
  if File.exist?("app/assets/stylesheets/application.tailwind.css")
    append_to_file "app/assets/stylesheets/application.tailwind.css" do
      "\n@import 'actiontext.css';\n"
    end
  end
end