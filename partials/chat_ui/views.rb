def setup_chat_views
  # Chat UI inherits the design-system brand tokens applied by the wizard
  @chat_theme = {
    body: "bg-brand-canvas text-brand-text-primary font-sans",
    sidebar: {
      container: "bg-brand-surface border-r border-brand-border-default",
      header_border: "border-brand-border-subtle",
      header_text: "text-brand-text-primary tracking-tight",
      link_base: "text-brand-text-secondary hover:text-brand-text-primary hover:bg-brand-surface-elevated",
      link_active: "bg-brand-surface-elevated text-brand-text-primary",
      back_link: "text-brand-text-muted hover:text-brand-text-primary",
      btn: "ds-btn-primary"
    },
    main: {
      bg: "bg-brand-canvas",
      header_border: "border-brand-border-subtle",
      header_text: "text-brand-text-primary",
      placeholder: "text-brand-text-muted",
      input_container: "bg-brand-canvas border-t border-brand-border-subtle",
      input: "bg-brand-surface border border-brand-border-default text-brand-text-primary placeholder:text-brand-text-muted focus:border-brand-border-focus focus:ring-brand-border-focus",
      loader_color: "bg-brand-action",
      loader_text: "text-brand-action"
    },
    message: {
      user_bg: "bg-brand-action text-white",
      user_icon: "bg-brand-action",
      bot_bg: "bg-brand-surface border border-brand-border-default text-brand-text-primary",
      bot_icon: "bg-brand-automation",
      source_box: "bg-brand-surface-elevated border-brand-border-subtle",
      source_link: "hover:bg-brand-surface-elevated text-brand-action"
    }
  }

  apply File.join(__dir__, "views", "layout.rb")
  apply File.join(__dir__, "views", "index.rb")
  apply File.join(__dir__, "views", "show.rb")
  apply File.join(__dir__, "views", "helpers.rb")
  apply File.join(__dir__, "views", "sources_partial.rb")
  apply File.join(__dir__, "views", "message_partial.rb")
  apply File.join(__dir__, "views", "tailwind.rb")

  setup_chat_view_layout
  setup_chat_view_index
  setup_chat_view_show
  setup_chat_view_helpers
  setup_chat_view_sources_partial
  setup_chat_view_message_partial
  setup_chat_view_tailwind
end
