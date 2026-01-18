if @install_pagy
  create_file 'docs/pagination.md', <<~MARKDOWN
    # Pagination (Pagy)

    ## Quick Start
    Use `pagy` in controllers and `<%== @pagy.nav %>` in views.
    See `config/initializers/pagy.rb` for configuration.
  MARKDOWN
end
