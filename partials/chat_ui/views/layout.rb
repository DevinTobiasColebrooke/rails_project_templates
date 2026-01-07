def setup_chat_view_layout
  create_file "app/views/layouts/chat.html.erb", <<~ERB
    <!DOCTYPE html>
    <html>
      <head>
        <title><%= content_for(:title) || "Recon AI" %></title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
      </head>
      <body class="bg-slate-900 text-slate-100 h-screen flex overflow-hidden font-sans">
        <%= yield %>
      </body>
    </html>
  ERB
end