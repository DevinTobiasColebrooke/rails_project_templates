require 'json'

def setup_public_layout
  apply File.join(__dir__, 'layouts', 'admin.rb')

  if @install_ui && @selected_theme && @selected_theme != 'none'
    setup_design_system
  else
    puts '    -> Skipping layout generation (no UI theme selected).'
  end
end

def setup_design_system
  theme_dir = File.expand_path(File.join('..', 'design_systems', @selected_theme), __dir__)
  meta = JSON.parse(File.read(File.join(theme_dir, 'system.json')))

  # 1. Drop the design system Tailwind theme into the app
  create_file 'app/assets/tailwind/design_system.css', File.read(File.join(theme_dir, 'tailwind.css')), force: true

  # 2. Import it from the Tailwind entrypoint
  app_css = 'app/assets/tailwind/application.css'
  if File.exist?(app_css) && !File.read(app_css).include?('design_system.css')
    if File.read(app_css).include?('@import "tailwindcss";')
      inject_into_file app_css, after: %(@import "tailwindcss";\n) do
        %(\n@import "./design_system.css";\n)
      end
    else
      append_to_file app_css, %(\n@import "./design_system.css";\n)
    end
  end

  # 3. Keep the machine-readable spec and prompt with the project for agents
  create_file 'docs/design_system.md', File.read(File.join(theme_dir, 'prompt.md')), force: true
  create_file 'docs/design_system.json', File.read(File.join(theme_dir, 'system.json')), force: true

  # 4. Generate the base layout
  setup_design_system_layout(meta)

  puts "    🎨  #{meta['name']} design system installed (native mode: #{meta['native_mode']})."
end

def setup_design_system_layout(meta)
  native_mode = meta['native_mode'] || (meta['is_dark'] ? 'dark' : 'light')

  create_file 'app/views/layouts/application.html.erb', <<~ERB, force: true
    <!DOCTYPE html>
    <html class="h-full" data-theme="#{native_mode}" data-design-system="#{meta['slug']}">
      <head>
        <title>#{app_name.titleize} | <%= yield(:title) %></title>
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
      </head>
      <body class="min-h-full bg-brand-canvas text-brand-text-primary font-sans antialiased">
        <%= render 'shared/menu' %>
        <main class="container mx-auto px-4 py-8">
          <%= render 'shared/flash' %>
          <%= yield %>
        </main>
      </body>
    </html>
  ERB
end
