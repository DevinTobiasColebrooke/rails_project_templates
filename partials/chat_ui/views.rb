def setup_chat_views
  # 1. Chat Layout
  # Matches ReconUi app/views/layouts/application.html.erb but scoped to 'chat'
  create_file "app/views/layouts/chat.html.erb", <<~ERB
    <!DOCTYPE html>
    <html>
      <head>
        <title><%= content_for(:title) || "Recon AI" %></title>
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="mobile-web-app-capable" content="yes">
        <%= csrf_meta_tags %>
        <%= csp_meta_tag %>
        
        <link rel="icon" href="/icon.png" type="image/png">
        <link rel="icon" href="/icon.svg" type="image/svg+xml">
        <link rel="apple-touch-icon" href="/icon.png">

        <%= stylesheet_link_tag "tailwind", "inter-font", "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
        
        <!-- Marked.js for Markdown Rendering -->
        <script type="module">
          import { marked } from "marked";
          window.marked = marked;
        </script>  
      </head>

      <!-- Dark Mode / Full Screen Layout -->
      <body class="bg-slate-900 text-slate-100 h-screen flex overflow-hidden font-sans">
        <%= yield %>
      </body>
    </html>
  ERB

  # 2. Conversations Index (Sidebar + Empty State)
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

  # 3. Conversation Show (The Main Chat Interface)
  # Includes duplicate sidebar (responsive hidden) and the chat area
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
          <% Conversation.order(updated_at: :desc).limit(50).each do |conv| %>
            <%= link_to conv.title, conversation_path(conv), class: "block px-3 py-2 rounded text-sm truncate \#{conv.id == @conversation.id ? 'bg-slate-800 text-white' : 'text-slate-400 hover:bg-slate-900'}" %>
          <% end %>
        </div>
        <div class="p-4 border-t border-slate-800 text-xs text-slate-500">
          <%= link_to "← Back to App", root_path, class: "hover:text-white" %>
        </div>
      </div>

      <!-- Chat Area -->
      <div class="flex-1 flex flex-col min-w-0 bg-slate-900">
        <!-- Header -->
        <div class="h-14 border-b border-slate-800 flex items-center justify-between px-6 bg-slate-900">
          <h2 class="font-medium text-slate-200 truncate"><%= @conversation.title %></h2>
          <%= button_to "Delete", conversation_path(@conversation), method: :delete, class: "text-xs text-red-500 hover:text-red-400 cursor-pointer" %>
        </div>

        <!-- Messages List -->
        <%= turbo_stream_from @conversation %>
        <!-- Added id="messages" to match the Model target -->
        <div id="messages" class="flex-1 overflow-y-auto p-6 space-y-6 scroll-smooth" data-controller="scroll">
          <%= render @messages %>
        </div>
        
        <!-- Thinking/Loading Indicator -->
        <div data-loader-target="indicator" class="hidden px-6 pb-4 bg-slate-900 flex flex-col items-start animate-pulse border-t border-slate-800 pt-4">
          <div class="flex items-center gap-2">
            <div class="w-2 h-2 bg-blue-500 rounded-full animate-bounce" style="animation-delay: 0s"></div>
            <div class="w-2 h-2 bg-blue-500 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
            <div class="w-2 h-2 bg-blue-500 rounded-full animate-bounce" style="animation-delay: 0.4s"></div>
            <span class="text-xs text-slate-500 font-mono ml-2">Agent is researching...</span>
          </div>
        </div>

        <!-- Input Area -->
        <div class="p-4 bg-slate-900">
          <%= form_with url: conversation_messages_path(@conversation), 
              class: "relative max-w-4xl mx-auto", 
              data: { 
                controller: "reset-form", 
                action: "turbo:submit-start->reset-form#clear turbo:submit-start->loader#show turbo:submit-end->loader#hide" 
              } do |f| %>
            
            <%= f.text_area :content, 
                data: { reset_form_target: "input" },
                placeholder: "Ask a research question...", 
                class: "w-full bg-slate-800 border-slate-700 rounded-xl px-4 py-3 pr-12 text-white focus:ring-2 focus:ring-blue-600 focus:border-transparent resize-none placeholder-slate-500",
                rows: 1,
                onkeydown: "if(event.key === 'Enter' && !event.shiftKey) { event.preventDefault(); this.form.requestSubmit(); }"
            %>
            
            <button type="submit" class="absolute right-3 top-3 text-slate-400 hover:text-white cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5">
                <path d="M3.105 2.289a.75.75 0 00-.826.95l1.414 4.925A1.5 1.5 0 005.135 9.25h6.115a.75.75 0 010 1.5H5.135a1.5 1.5 0 00-1.442 1.086l-1.414 4.926a.75.75 0 00.826.95 28.896 28.896 0 0015.293-7.154.75.75 0 000-1.115A28.897 28.897 0 003.105 2.289z" />
              </svg>
            </button>
          <% end %>
        </div>
      </div>
    </div>
  ERB

  # 4. Message Partial
  create_file "app/views/messages/_message.html.erb", <<~ERB
    <div class="flex flex-col <%= message.role == 'user' ? 'items-end' : 'items-start' %> group">
      <div class="max-w-3xl <%= message.role == 'user' ? 'bg-blue-600 text-white' : 'bg-slate-800 text-slate-200' %> rounded-2xl px-5 py-4 shadow-sm">
        <% if message.role == 'assistant' %>
          
          <div class="prose prose-invert prose-sm max-w-none" data-controller="markdown">
            <%= message.content %>
          </div>

          <% if message.metadata["logs"].present? %>
            <details class="mt-4 border-t border-slate-700 pt-2">
              <summary class="text-xs font-mono text-slate-500 cursor-pointer hover:text-slate-300 select-none">
                View Research Logs (<%= message.metadata["logs"].size %>)
              </summary>
              <div class="mt-2 space-y-1 font-mono text-[10px] text-green-400 bg-slate-950 p-2 rounded max-h-48 overflow-y-auto">
                <% message.metadata["logs"].each do |log| %>
                  <div class="opacity-80">
                    <span class="text-slate-600">[<%= Time.parse(log["time"]).strftime('%T') rescue '00:00' %>]</span> 
                    <%= log["msg"] %>
                  </div>
                <% end %>
              </div>
            </details>
          <% end %>
        <% else %>
          <div class="whitespace-pre-wrap"><%= message.content %></div>
        <% end %>
      </div>
      <span class="text-[10px] text-slate-600 mt-1 px-2">
        <%= message.role.humanize %> • <%= message.created_at.strftime("%I:%M %p") %>
      </span>
    </div>
  ERB
end