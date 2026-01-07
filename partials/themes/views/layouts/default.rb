def setup_default_layout
  # The standard layout (uses menu partial)
  gsub_file 'app/views/layouts/application.html.erb', /<body[^>]*>(.*?)<\/body>/m do
    <<-ERB
  <body class="bg-gray-50 text-gray-900 font-sans">
    <%= render 'shared/menu' %>
    <main class="container mx-auto px-4 py-8">
      <%= render 'shared/flash' %>
      <%= yield %>
    </main>
  </body>
    ERB
  end
end