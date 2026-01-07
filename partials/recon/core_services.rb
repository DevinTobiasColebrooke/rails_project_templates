require_relative "core_services/api_client_base"
require_relative "core_services/college_scorecard_client"
require_relative "core_services/embedding_generator"
require_relative "core_services/web_searcher"
require_relative "core_services/google_searcher"
require_relative "core_services/rag_engine"

def setup_recon_core_services
  # Refactored generic services into Models/POROs
  
  # 1. Base API Model
  setup_api_client_base

  # 2. College Scorecard Model
  setup_college_scorecard_client

  # 3. Embedding Generator Model
  setup_embedding_generator

  # 4. Web Searcher Model (Generic)
  setup_web_searcher

  # 5. Google Searcher Model
  setup_google_searcher

  # 6. RAG Engine Model
  setup_rag_engine
end