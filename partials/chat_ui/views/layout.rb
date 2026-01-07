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
        <style>
           /* Ensure code blocks look good in markdown */
           .prose pre { background-color: #1e293b; color: #e2e8f0; }
        </style>
      </head>
      <body class="#{@chat_theme[:body]} h-screen flex overflow-hidden">
        <%= yield %>
      </body>
    </html>
  ERB
end