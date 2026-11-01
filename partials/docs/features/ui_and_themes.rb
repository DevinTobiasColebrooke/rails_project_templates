if @install_ui
  create_file 'docs/ui_and_themes.md', <<~MARKDOWN
    # UI & Theming

    ## Themes
    A complete design system is installed at `app/assets/tailwind/design_system.css`
    and imported from `app/assets/tailwind/application.css`.

    - Use the `brand-*` utilities everywhere: `bg-brand-canvas`, `bg-brand-surface`,
      `text-brand-text-primary`, `text-brand-action`, `border-brand-border-default`, ...
    - Use the `.ds-*` component recipes: `.ds-card`, `.ds-btn-primary`,
      `.ds-btn-secondary`, `.ds-status`, ...
    - The app ships with a dark **and** light palette. Flip modes by setting
      `data-theme="light"` or `data-theme="dark"` on the `<html>` element.
    - The full design brief is in `docs/design_system.md`; the machine-readable
      spec (tokens, fonts, schemas) is in `docs/design_system.json`.

    Re-installing a different design system is a matter of replacing
    `app/assets/tailwind/design_system.css` with another system's `tailwind.css`.

    ## Admin Panel
    #{@install_admin ? 'Access via `/admin`. Logic in `app/controllers/admin/`.' : 'Not installed.'}

    ## Components
    - **Flash**: `app/views/shared/_flash.html.erb`
    - **Menu**: `app/views/shared/_menu.html.erb`
  MARKDOWN
end
