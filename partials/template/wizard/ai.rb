puts "\n🤖  AI & Research Configuration"
@install_gemini = yes?("    Add Google Gemini Service?")
if @install_gemini
  @gemini_key = fetch_config("    🔑  (Optional) Enter Gemini API Key:", "TEMPLATE_GEMINI")
end

@install_recon  = yes?("    Add Deep Research Agent (Recon)?")
if @install_recon
  puts "    🔑  Google Custom Search Credentials (for Recon):"
  @google_search_key = fetch_config("        Search API Key:", "TEMPLATE_GOOGLE_SEARCH_KEY")
  @google_search_id  = fetch_config("        Search Engine ID:", "TEMPLATE_GOOGLE_SEARCH_CX")
end

if @install_recon
  puts "    -> 🕵️‍♂️  Recon Agent selected."
  puts "    -> 📦 Auto-enabling Local AI and Vector DB (Required dependencies)."
  @install_local = true
  @install_vector_db = true
else
  @install_local = yes?("    Add Local AI (Llama via Windows/WSL)?")
  
  puts "\n🧠  Knowledge Base"
  @install_vector_db = yes?("    Add Vector Database (pgvector + Neighbor)?")
end

if @install_gemini || @install_local || @install_recon
  @install_prompts = true
  puts "    -> 🧠 Prompt Management System auto-enabled for AI."
else
  @install_prompts = yes?("    Add Prompt Management System (Standalone)?")
end