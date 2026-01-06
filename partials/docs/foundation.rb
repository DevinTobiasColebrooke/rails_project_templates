def setup_docs_foundation
  puts "    ...scaffolding Project Foundation documents"
  empty_directory "docs/project_foundation"

  create_file "docs/project_foundation/architecture_blueprint.md", <<~MARKDOWN
    # Architecture Blueprint

    ## System Overview
    <!-- TODO: Describe the high-level goal and architecture of the application. -->

    ## Tech Stack Decisions
    - **Framework**: Rails 8
    - **Database**: PostgreSQL (pgvector enabled)
    - **Frontend**: Tailwind CSS + ERB
    - **AI**: #{@install_gemini ? 'Gemini' : ''} #{@install_local ? 'Local Llama' : ''}

    ## Core Components
    <!-- TODO: List services, modules, and external integrations (e.g., Stripe, Data.gov). -->

    ## Data Flow
    <!-- TODO: Describe how data moves through the system (e.g., User -> Controller -> Service -> AI -> DB). -->
  MARKDOWN

  create_file "docs/project_foundation/uml_sequence_diagrams.md", <<~MARKDOWN
    # UML Sequence Diagrams

    Use [Mermaid.js](https://mermaid.js.org/syntax/sequenceDiagram.html) syntax to document complex logic.

    ## Critical Paths
    <!-- TODO: Add sequence diagrams for critical paths (e.g., User Signup, Payment Flow, AI RAG Pipeline). -->

    ### Example: Basic Flow
    ```mermaid
    sequenceDiagram
        participant User
        participant RailsApp
        participant Database
        
        User->>RailsApp: GET /dashboard
        RailsApp->>Database: Query User Data
        Database-->>RailsApp: Return Data
        RailsApp-->>User: Render View
    ```
  MARKDOWN

  create_file "docs/project_foundation/database_schema.md", <<~MARKDOWN
    # Database Schema Plan

    ## Entity Relationship Diagram (ERD)
    <!-- TODO: Add Mermaid ER Diagram here -->

    ```mermaid
    erDiagram
        USER ||--o{ POST : has
        USER {
            string email
            string password_digest
        }
        POST {
            string title
            text content
        }
    ```

    ## Table Definitions

    ### Users
    | Column | Type | Constraints | Description |
    |--------|------|-------------|-------------|
    | id     | uuid | PK          |             |
    | email  | string| unique, index|             |

    <!-- TODO: Add planned tables here before generating migrations -->
  MARKDOWN

  create_file "docs/project_foundation/implementation_plan.md", <<~MARKDOWN
    # Implementation Plan

    This document serves as the roadmap for building the application features defined in the [Architecture Blueprint](./architecture_blueprint.md) and [Database Schema](./database_schema.md).

  MARKDOWN
end