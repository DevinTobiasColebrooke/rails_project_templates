def setup_docs_features
  puts '    ...generating Feature specific documentation'

  # 1. Authentication
  apply File.join(__dir__, 'features/authentication.rb')

  # 2. Storage & Rich Text
  apply File.join(__dir__, 'features/content_and_storage.rb')

  # 3. AI & Data
  apply File.join(__dir__, 'features/ai_and_data.rb')

  # 4. Stripe
  apply File.join(__dir__, 'features/payments.rb')

  # 5. UI
  apply File.join(__dir__, 'features/ui_and_themes.rb')

  # 6. Ops
  apply File.join(__dir__, 'features/operations.rb')

  # 7. Pagination (Pagy)
  apply File.join(__dir__, 'features/pagination.rb')
end
