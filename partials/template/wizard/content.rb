puts "\n🧱  Content & Data"
@install_active_storage = yes?("    📦  Add Active Storage (File Uploads)?")
@install_action_text    = yes?("    📝  Add Action Text (Rich Text Editor)?")
@install_api            = yes?("    Add API Services (Data.gov example)?")

if @install_api
  @data_gov_key = fetch_config("    🔑  (Optional) Enter Data.gov API Key:", "TEMPLATE_DATA_GOV")
end

# Pagy is now auto-included as standard
@install_pagy = true
puts "    -> 📄 Pagination (Pagy) auto-enabled."