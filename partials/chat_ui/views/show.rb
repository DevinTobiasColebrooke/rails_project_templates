def setup_chat_view_show
  sidebar_query = @install_auth ? "current_user.conversations" : "Conversation"

  create_file "app/views/conversations/show.html.erb", <<~ERB
    <div class="flex h-full w-full" data-controller="loader">
      <!-- Sidebar -->
      <div class="w-64 bg-slate-950 border-r border-slate-800 flex flex-col shrink-0 hidden md:flex">
        <div class="p-4 border-b border-slate-800">
          <h1 class="font-bold text-xl tracking-tight"><%= link_to "Recon AI", conversations_path, class: "text-white no-underline" %></h1>
        </div>
        <div class="p-4">
          <%= button_to "+ New Research", conversations_path, class: "w-full bg-blue-600 hover:bg-blue-500 text-white py-2 px-4 rounded transition text-sm font-medium cursor-pointer" %>
        </div>
        <div class="flex-1 overflow-y-auto px-2 space-y-1">
          <% #{sidebar_query}.order(updated_at: :desc).limit(50).each do |conv| %>
            <%= link_to conv.title, conversation_path(conv), class: "block px-3 py-2 rounded text-sm truncate \#{conv.id == @conversation.id ? 'bg-slate-800 text-white' : 'text-slate-400 hover:bg-slate-900'}" %>
          <% end %>
        </div>
      </div>

      <!-- Chat Area -->
      <div class="flex-1 flex flex-col min-w-0 bg-slate-900">
        <div class="h-14 border-b border-slate-800 flex items-center justify-between px-6 bg-slate-900">
          <h2 class="font-medium text-slate-200 truncate"><%= @conversation.title %></h2>
          <%= button_to "Delete", conversation_path(@conversation), method: :delete, class: "text-xs text-red-500 hover:text-red-400 cursor-pointer" %>
        </div>

        <%= turbo_stream_from @conversation %>
        <div id="messages" class="flex-1 overflow-y-auto p-6 space-y-6 scroll-smooth" data-controller="scroll">
          <%= render @messages %>
          
          <div data-loader-target="indicator" class="hidden flex gap-4 flex-row group mb-6 animate-pulse">
             <div class="shrink-0 w-8 h-8 rounded-lg flex items-center justify-center bg-blue-600/20">
               <div class="w-2 h-2 bg-blue-500 rounded-full animate-spin"></div>
            </div>
            <div class="flex flex-col max-w-[85%] items-start">
              <div class="bg-slate-800 text-slate-200 rounded-2xl px-5 py-4 flex items-center gap-3">
                 <span class="text-blue-400 font-medium text-sm">Agent is researching...</span>
              </div>
            </div>
          </div>
        </div>

        <div class="p-4 bg-slate-900 border-t border-slate-800">
          <%= form_with url: conversation_messages_path(@conversation), 
              class: "relative max-w-4xl mx-auto", 
              data: { 
                controller: "reset-form", 
                action: "turbo:submit-start->reset-form#clear turbo:submit-start->loader#show turbo:submit-end->loader#hide" 
              } do |f| %>
            <%= f.text_area :content, data: { reset_form_target: "input" }, placeholder: "Ask a research question...", class: "w-full bg-slate-800 border-slate-700 rounded-xl px-4 py-3 text-white resize-none" %>
            <button type="submit" class="absolute right-3 top-3 text-slate-400 hover:text-white cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5"><path d="M3.105 2.289a.75.75 0 00-.826.95l1.414 4.925A1.5 1.5 0 005.135 9.25h6.115a.75.75 0 010 1.5H5.135a1.5 1.5 0 00-1.442 1.086l-1.414 4.926a.75.75 0 00.826.95 28.896 28.896 0 0015.293-7.154.75.75 0 000-1.115A28.897 28.897 0 003.105 2.289z" /></svg>
            </button>
          <% end %>
        </div>
      </div>
    </div>
  ERB
end