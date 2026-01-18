if @install_gemini || @install_local || @install_vector_db || @install_searxng

  ai_content = "## AI Providers\n"
  if @install_gemini
    ai_content += "- **Gemini**: Use `GoogleGeminiService`. Requires `google: gemini_key` in credentials.\n"
  end
  if @install_local
    ai_content += "- **Local Llama**: Use `LocalLlmService`. Connects to Windows host on port 9090. See `config/initializers/ai_config.rb`.\n"
  end
  if @install_searxng
    ai_content += "- **SearXNG**: Use `WebSearchService`. Connects to `ENV['SEARXNG_URL']` (Default: localhost:8888).\n"
  end

  if @install_vector_db
    ai_content += <<~MARKDOWN

      ## Vector Database
      - **Model**: `Document` (content, embedding, metadata).
      - **Usage**: `Document.semantic_search("query")`.
      - **Embeddings**: Auto-generated via `EmbeddingService`.
    MARKDOWN
  end

  if @install_prompts
    ai_content += <<~MARKDOWN

      ## Prompt Management
      - Edit prompts in `config/prompts.yml`.
      - Access via `Prompt.get('key')`.
    MARKDOWN
  end

  if @install_searxng
    ai_content += <<~MARKDOWN

      ## Web Search Tools
      - **Service**: `app/services/web_search_service.rb`
      - **Tool Wrapper**: `app/models/tools/searxng_search_tool.rb`
      - **Dependency**: `ferrum` gem (Headless Chrome) is installed for scraping content.
    MARKDOWN
  end

  if @install_recon
    ai_content += <<~MARKDOWN

      ## Deep Research Agent (Recon)
      A specialized autonomous agent for performing deep web research, content analysis, and report synthesis.

      ### Architecture
      The agent operates as an orchestrator managing a research loop:
      1. **ResearchAgent** (`app/models/research_agent.rb`): The main entry point. It manages the conversation history, tool execution, and the thinking loop (Plan -> Search -> Visit -> Synthesize).
      2. **ResearchContext** (`app/models/research_context.rb`): Manages short-term memory and caching of visited pages to optimize performance.
      3. **Tools** (`app/models/tools/`):
         - `GoogleSearch`: Queries Google Custom Search for high-quality, official sources.
         - `SearxngSearch`: Broad search for diverse viewpoints.
         - `VisitPage`: Fetches and reads the full content of a URL.
      4. **Core Services** (`app/models/core_services/`):
         - `WebSearcher`: Generic interface for search providers.
         - `EmbeddingGenerator`: Creates vector embeddings for semantic understanding.
         - `RagEngine`: Handles Retrieval-Augmented Generation for context injection.

      ### Data Models
      - **ReconnaissanceLog**: Stores the full audit trail of a research session, including the final report and intermediate thought processes.
      - **WebDocument**: Stores crawled web pages with their vector embeddings (768 dimensions) for semantic similarity search.

      ### Usage
      **API Endpoint**: `POST /recon`

      **Parameters**:
      - `query`: The main research goal (e.g., "Market analysis of EV batteries").
      - `location`: (Optional) Geographic context.
      - `domain`: (Optional) Specific industry or domain constraint.

      **Example**:
      ```bash
      curl -X POST http://localhost:3000/recon \\
        -H "Content-Type: application/json" \\
        -d '{"query": "Latest trends in solid-state batteries"}'
      ```

      ### Adapt & Extend (Creating New Agents)
      The Recon agent architecture is designed to be a blueprint. You can copy and adapt these files to create specialized agents (e.g., a "Health Analysis Agent" or "Legal Analyst").

      **Steps to Clone & Modify:**

      1. **Clone the Agent Model**:
         - Copy `app/models/research_agent.rb` to `app/models/health_agent.rb`.
         - Rename class to `HealthAgent`.

      2. **Define New Tools**:
         - Create specific tools in `app/models/tools/`.
         - Example: `app/models/tools/pubmed_search.rb` for medical journals.
         - Register them in `HealthAgent#initialize`:
           ```ruby
           @tools = [Tools::PubmedSearch, Tools::VisitPage]
           ```

      3. **Update the Prompt**:
         - Modify the `system_prompt` method in `HealthAgent`.
         - Change the persona: "You are a senior medical analyst..."
         - Update instructions to focus on clinical data, verifying sources against medical journals, etc.

      4. **Adjust Data Logging (Optional)**:
         - Reuse `ReconnaissanceLog` if the structure fits, or create `HealthLog`.
         - If reusing, pass `search_method: "health_analysis"` in `persist_log`.

      5. **Expose Endpoint**:
         - Copy `app/controllers/recon_controller.rb` to `app/controllers/health_controller.rb`.
         - Update the action to instantiate `HealthAgent.new`.
         - Add route: `post "health", to: "health#create"`.

      By following this pattern, you can rapidly deploy domain-specific agents without rebuilding the orchestration logic.
    MARKDOWN
  end

  create_file 'docs/ai_and_data.md', <<~MARKDOWN
    # AI & Data Services

    ## Configuration
    Check `config/initializers/ai_config.rb` for settings regarding IP detection (WSL/Windows) and API keys.

    #{ai_content}
  MARKDOWN
end
