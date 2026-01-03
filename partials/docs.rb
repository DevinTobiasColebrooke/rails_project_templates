# partials/docs.rb

def setup_docs
  puts "📚  Generating Project Documentation..."
  empty_directory "docs"

  # Load the sub-modules
  # We use __dir__ to find the files inside the 'docs' subdirectory relative to this file
  apply File.join(__dir__, 'docs', 'foundation.rb')
  apply File.join(__dir__, 'docs', 'features.rb')
  apply File.join(__dir__, 'docs', 'readme.rb')

  # Execute the methods defined in the sub-modules
  setup_docs_foundation
  setup_docs_features
  setup_docs_readme
end