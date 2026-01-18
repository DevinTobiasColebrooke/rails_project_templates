if @install_ui
  create_file 'docs/ui_and_themes.md', <<~MARKDOWN
    # UI & Theming

    ## Themes
    Edit `config/themes.yml` to change color palettes without touching CSS.

    ## Admin Panel
    #{@install_admin ? 'Access via `/admin`. Logic in `app/controllers/admin/`.' : 'Not installed.'}

    ## Components
    - **Flash**: `app/views/shared/_flash.html.erb`
    - **Menu**: `app/views/shared/_menu.html.erb`
  MARKDOWN
end
