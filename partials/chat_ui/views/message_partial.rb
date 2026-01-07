def setup_chat_view_message_partial
  create_file "app/views/messages/_message.html.erb", <<~ERB
    <div class="flex gap-4 <%= message.role == 'user' ? 'flex-row-reverse' : 'flex-row' %> group mb-6">
      <div class="shrink-0 w-8 h-8 rounded-lg flex items-center justify-center <%= message.role == 'user' ? 'bg-gray-700' : 'bg-indigo-600' %>">
        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
      </div>
      <div class="flex flex-col max-w-[85%] md:max-w-3xl min-w-0 <%= message.role == 'user' ? 'items-end' : 'items-start' %>">
        <div class="<%= message.role == 'user' ? 'bg-gray-800 text-gray-100 rounded-2xl' : 'bg-transparent text-gray-100' %> px-5 py-3 w-full">
          <% if message.role == 'assistant' %>
            <% content, sources = parse_markdown_with_sources(message.content) %>
            <div class="prose prose-invert prose-sm">
              <%= markdown(content) %>
            </div>
            <%= render "messages/sources", sources: sources %>
          <% else %>
            <div class="whitespace-pre-wrap"><%= message.content %></div>
          <% end %>
        </div>
      </div>
    </div>
  ERB
end