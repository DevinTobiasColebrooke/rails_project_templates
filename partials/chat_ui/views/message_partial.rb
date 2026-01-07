def setup_chat_view_message_partial
  t = @chat_theme

  create_file "app/views/messages/_message.html.erb", <<~ERB
    <div class="flex gap-4 <%= message.role == 'user' ? 'flex-row-reverse' : 'flex-row' %> group mb-6">
      
      <!-- Icon -->
      <div class="shrink-0 w-8 h-8 rounded-lg flex items-center justify-center <%= message.role == 'user' ? '#{t[:message][:user_icon]}' : '#{t[:message][:bot_icon]}' %>">
        <% if message.role == 'user' %>
          <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
        <% else %>
          <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
        <% end %>
      </div>

      <!-- Bubble -->
      <div class="flex flex-col max-w-[85%] md:max-w-3xl min-w-0 <%= message.role == 'user' ? 'items-end' : 'items-start' %>">
        <div class="px-5 py-3 w-full rounded-2xl <%= message.role == 'user' ? '#{t[:message][:user_bg]}' : '#{t[:message][:bot_bg]}' %>">
          <% if message.role == 'assistant' %>
            <% content, sources = parse_markdown_with_sources(message.content) %>
            <div class="prose prose-sm max-w-none">
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