def setup_chat_view_index
  create_file "app/views/conversations/index.html.erb", <<~ERB
    <div class="w-64 bg-slate-950 border-r border-slate-800 flex flex-col">
      <div class="p-4 border-b border-slate-800">
        <h1 class="font-bold text-xl tracking-tight text-white">🕵️‍♂️ Recon AI</h1>
      </div>
      <div class="p-4">
        <%= button_to "+ New Research", conversations_path, class: "w-full bg-blue-600 hover:bg-blue-500 text-white py-2 px-4 rounded transition text-sm font-medium cursor-pointer" %>
      </div>
      <div class="flex-1 overflow-y-auto px-2 space-y-1">
        <% @conversations.each do |conv| %>
          <%= link_to conv.title, conversation_path(conv), class: "block px-3 py-2 rounded hover:bg-slate-800 text-slate-400 hover:text-white text-sm truncate" %>
        <% end %>
      </div>
      <div class="p-4 border-t border-slate-800 text-xs text-slate-500">
        <%= link_to "← Back to App", root_path, class: "hover:text-white" %>
      </div>
    </div>
    <div class="flex-1 flex items-center justify-center bg-slate-900">
      <div class="text-center text-slate-500">
        <p class="text-lg">Select a conversation or start a new one.</p>
      </div>
    </div>
  ERB
end