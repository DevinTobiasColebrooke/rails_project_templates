if @install_ops
  create_file 'docs/operations.md', <<~MARKDOWN
    # Operations & Observability

    - **Rack Attack**: Configured in `config/initializers/rack_attack.rb`.
    - **Bullet**: Checks for N+1 queries in Development.
    - **Ahoy**: Analytics enabled. Check `Ahoy::Visit` and `Ahoy::Event`.
  MARKDOWN
end
