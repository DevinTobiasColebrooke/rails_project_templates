def setup_rich_text
  puts "📝  Installing Action Text..."
  
  # Install Action Text
  action "action_text:install"
  
  # Improve Trix Styling with Tailwind
  # We append this to the application.tailwind.css (or standard css)
  append_to_file "app/assets/stylesheets/application.css", <<~CSS

    /* Action Text / Trix Overrides */
    .trix-content {
      @apply prose prose-lg max-w-none;
    }
    .trix-content h1 {
      @apply text-3xl font-bold mb-4;
    }
    .trix-content a {
      @apply text-blue-600 underline;
    }
    .trix-content blockquote {
      @apply border-l-4 border-gray-300 pl-4 italic;
    }
  CSS
end