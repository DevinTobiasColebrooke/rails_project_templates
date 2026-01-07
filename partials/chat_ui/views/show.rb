def setup_chat_view_show
  sidebar_query = @install_auth ? "current_user.conversations" : "Conversation"
  t = @chat_theme

  create_file "app/views/conversations/show.html.erb", <<~ERB
    <div class="flex h-full w-full" data-controller="loader">
      <!-- Sidebar (Desktop) -->
      <div class="w-64 flex flex-col shrink-0 hidden md:flex #{t[:sidebar][:container]}">
        <div class="p-4 border-b #{t[:sidebar][:header_border]}">
          <h1 class="font-bold text-xl #{t[:sidebar][:header_text]}"><%= link_to "Recon AI", conversations_path, class: "no-underline text-inherit" %></h1>
        </div>
        <div class="p-4">
          <%= button_to "+ New Research", conversations_path, class: "w-full py-2 px-4 rounded transition text-sm font-medium cursor-pointer #{t[:sidebar][:btn]}" %>
        </div>
        <div class="flex-1 overflow-y-auto px-2 space-y-1">
          <% #{sidebar_query}.order(updated_at: :desc).limit(50).each do |conv| %>
            <%= link_to conv.title, conversation_path(conv), class: "block px-3 py-2 rounded text-sm truncate \#{conv.id == @conversation.id ? '#{t[:sidebar][:link_active]}' : '#{t[:sidebar][:link_base]}'}" %>
          <% end %>
        </div>
        <div class="p-4 border-t #{t[:sidebar][:header_border]} text-xs">
          <%= link_to "← Back to App", root_path, class: "#{t[:sidebar][:back_link]}" %>
        </div>
      </div>

      <!-- Chat Area -->
      <div class="flex-1 flex flex-col min-w-0 #{t[:main][:bg]}">
        <!-- Header -->
        <div class="h-14 border-b flex items-center justify-between px-6 shrink-0 #{t[:main][:header_border]}">
          <h2 class="font-medium truncate #{t[:main][:header_text]}"><%= @conversation.title %></h2>
          <%= button_to "Delete", conversation_path(@conversation), method: :delete, class: "text-xs text-red-500 hover:text-red-400 cursor-pointer" %>
        </div>

        <%= turbo_stream_from @conversation %>
        
        <!-- Messages -->
        <div id="messages" class="flex-1 overflow-y-auto p-6 space-y-6 scroll-smooth" data-controller="scroll">
          <%= render @messages %>
          
          <!-- Loading Indicator -->
          <div data-loader-target="indicator" class="hidden flex gap-4 flex-row group mb-6 animate-pulse">
             <div class="shrink-0 w-8 h-8 rounded-lg flex items-center justify-center bg-current opacity-20">
               <div class="w-2 h-2 bg-current rounded-full animate-spin"></div>
            </div>
            <div class="flex flex-col max-w-[85%] items-start">
              <div class="px-5 py-4 flex items-center gap-3">
                 <span class="font-medium text-sm #{t[:main][:loader_text]}">Agent is researching...</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Input Area -->
        <div class="p-4 #{t[:main][:input_container]}">
          <%= form_with url: conversation_messages_path(@conversation), 
              class: "relative max-w-4xl mx-auto", 
              data: { 
                controller: "reset-form", 
                action: "turbo:submit-start->reset-form#clear turbo:submit-start->loader#show turbo:submit-end->loader#hide" 
              } do |f| %>
            <%= f.text_area :content, data: { reset_form_target: "input" }, placeholder: "Ask a research question...", class: "w-full rounded-xl px-4 py-3 resize-none outline-none focus:ring-1 #{t[:main][:input]}" %>
            <button type="submit" class="absolute right-3 top-3 opacity-50 hover:opacity-100 cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5"><path d="M3.105 2.289a.75.75 0 00-.826.95l1.414 4.925A1.5 1.5 0 005.135 9.25h6.115a.75.75 0 010 1.5H5.135a1.5 1.5 0 00-1.442 1.086l-1.414 4.926a.75.75 0 00.826.95 28.896 28.896 0 0015.293-7.154.75.75 0 000-1.115A28.897 28.897 0 003.105 2.289z" /></svg>
            </button>
          <% end %>
        </div>
      </div>
    </div>
  ERB
end