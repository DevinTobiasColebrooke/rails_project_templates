def setup_chat_view_index
  t = @chat_theme

  create_file "app/views/conversations/index.html.erb", <<~ERB
    <!-- Sidebar -->
    <div class="w-64 flex flex-col shrink-0 #{t[:sidebar][:container]}">
      <div class="p-4 border-b #{t[:sidebar][:header_border]}">
        <h1 class="font-bold text-xl #{t[:sidebar][:header_text]}">🕵️‍♂️ Recon AI</h1>
      </div>
      <div class="p-4">
        <%= button_to "+ New Research", conversations_path, class: "w-full py-2 px-4 rounded transition text-sm font-medium cursor-pointer #{t[:sidebar][:btn]}" %>
      </div>
      <div class="flex-1 overflow-y-auto px-2 space-y-1">
        <% @conversations.each do |conv| %>
          <%= link_to conv.title, conversation_path(conv), class: "block px-3 py-2 rounded text-sm truncate #{t[:sidebar][:link_base]}" %>
        <% end %>
      </div>
      <div class="p-4 border-t #{t[:sidebar][:header_border]} text-xs">
        <%= link_to "← Back to App", root_path, class: "#{t[:sidebar][:back_link]}" %>
      </div>
    </div>

    <!-- Empty State -->
    <div class="flex-1 flex items-center justify-center #{t[:main][:bg]}">
      <div class="text-center #{t[:main][:placeholder]}">
        <p class="text-lg">Select a conversation or start a new one.</p>
      </div>
    </div>
  ERB
end