# partials/docs/readme.rb

def setup_docs_readme
  puts "    ...creating Docs Table of Contents"

  links = []
  links << "- [Project Foundation](./project_foundation/)"
  links << "- [Authentication](./authentication.md)" if @install_auth
  links << "- [AI & Data](./ai_and_data.md)" if @install_gemini || @install_local || @install_vector_db
  links << "- [Payments](./payments.md)" if @install_stripe
  links << "- [UI & Themes](./ui_and_themes.md)" if @install_ui
  links << "- [Operations](./operations.md)" if @install_ops

  create_file "docs/README.md", <<~MARKDOWN
    # Project Documentation

    This `docs/` folder contains specific setup and usage instructions for the features enabled in this application.

    ## Table of Contents
    #{links.join("\n")}
  MARKDOWN
end