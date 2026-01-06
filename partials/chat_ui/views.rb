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

        <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
        <%= javascript_importmap_tags %>
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
          
          <!-- Thinking/Loading Indicator (Bubble Style) -->
          <div data-loader-target="indicator" class="hidden flex gap-4 flex-row group mb-6 animate-pulse">
            <!-- Avatar -->
             <div class="shrink-0 w-8 h-8 rounded-lg flex items-center justify-center bg-blue-600/20">
               <div class="w-2 h-2 bg-blue-500 rounded-full animate-spin"></div>
            </div>

            <!-- Content -->
            <div class="flex flex-col max-w-[85%] md:max-w-3xl min-w-0 items-start">
              <div class="text-[10px] text-slate-500 mb-1 px-1">Recon AI</div>
              
              <div class="bg-slate-800 text-slate-200 rounded-2xl rounded-tl-sm px-5 py-4 shadow-sm w-full overflow-hidden flex items-center gap-3">
                 <span class="text-blue-400 font-medium text-sm">Agent is researching...</span>
                 <div class="flex gap-1">
                  <div class="w-1.5 h-1.5 bg-blue-500 rounded-full animate-bounce" style="animation-delay: 0s"></div>
                  <div class="w-1.5 h-1.5 bg-blue-500 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
                  <div class="w-1.5 h-1.5 bg-blue-500 rounded-full animate-bounce" style="animation-delay: 0.4s"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Input Area -->
        <div class="p-4 bg-slate-900 border-t border-slate-800">
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

  # 4. Inject Helper for Markdown and Source Parsing
  inject_into_file "app/helpers/application_helper.rb", after: "module ApplicationHelper\n" do
    <<~RUBY
      def markdown(text)
        return "" if text.blank?

        renderer = Redcarpet::Render::HTML.new(
          hard_wrap: true,
          filter_html: false
        )

        options = {
          autolink: true,
          tables: true,
          fenced_code_blocks: true,
          no_intra_emphasis: true,
          strikethrough: true,
          lax_spacing: true
        }

        Redcarpet::Markdown.new(renderer, options).render(text).html_safe
      end

      def parse_markdown_with_sources(text)
        return [ text, [] ] if text.blank?

        if text.include?("## Sources")
          content, sources_part = text.split("## Sources", 2)
          
          # Extract http/https URLs from the sources section
          # We clean up trailing punctuation often found in markdown (parentheses, dots, commas)
          sources = sources_part.scan(%r{https?://\\S+}).map { |url| url.gsub(/[).,;]+$/, "") }.uniq

          # Remove redundant "Source:" or "Sources:" lists that appear at the end of the content
          # This regex targets lists of links preceded by "Source:" or similar headers at the end of the content block
          redundant_pattern = /(?:\\r?\\n|\\A)\\s*(?:###\\s*)?(?:\\*\\*|__)?Sources?(?:\\*\\*|__)?\\s*:?\\s*(?:\\r?\\n)+((?:[-*]\\s+.*https?:\\/\\/.*\\r?\\n?)+)\\z/i
          content = content.gsub(redundant_pattern, "").strip

          [ content, sources ]
        else
          [ text, [] ]
        end
      end
    RUBY
  end

  # 5. Create Sources Partial
  create_file "app/views/messages/_sources.html.erb", <<~ERB
    <% if sources.any? %>
      <div class="mt-5 pt-4 border-t border-slate-700">
        <h4 class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-3 flex items-center gap-2">
          <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1" /></svg>
          Verified Sources
        </h4>
        <div class="grid grid-cols-1 gap-2">
          <% sources.each do |url| %>
            <a href="<%= url %>" target="_blank" rel="noopener noreferrer" class="flex items-center gap-3 p-3 rounded-lg bg-slate-900/50 hover:bg-slate-900 border border-slate-700 hover:border-slate-600 transition-all group no-underline">
              <div class="w-8 h-8 rounded-md bg-slate-800 flex items-center justify-center shrink-0 text-slate-400 group-hover:text-white font-bold text-xs uppercase">
                <%= URI.parse(url).host&.first || "?" %>
              </div>
              
              <div class="flex-1 min-w-0">
                <div class="truncate text-blue-400 group-hover:text-blue-300 font-medium text-sm">
                  <%= URI.parse(url).host %>
                </div>
                <div class="truncate text-xs text-slate-500 group-hover:text-slate-400">
                  <%= url %>
                </div>
              </div>
              
              <svg class="w-4 h-4 text-slate-500 group-hover:text-slate-300 opacity-0 group-hover:opacity-100 transition-opacity" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" /></svg>
            </a>
          <% end %>
        </div>
      </div>
    <% end %>
  ERB

  # 6. Message Partial (Updated to use Source parsing and server-side Markdown)
  create_file "app/views/messages/_message.html.erb", <<~ERB
    <div class="flex flex-col <%= message.role == 'user' ? 'items-end' : 'items-start' %> group">
      <div class="max-w-3xl <%= message.role == 'user' ? 'bg-blue-600 text-white' : 'bg-slate-800 text-slate-200' %> rounded-2xl px-5 py-4 shadow-sm">
        <% if message.role == 'assistant' %>
          <% content, sources = parse_markdown_with_sources(message.content) %>
          
          <div class="prose prose-invert prose-sm max-w-none">
            <%= markdown(content) %>
          </div>
          
          <%= render "messages/sources", sources: sources %>

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

  # 7. Configure Tailwind Typography Plugin (Necessary for prose classes)
  target_css = "app/assets/stylesheets/application.tailwind.css"
  if File.exist?(target_css)
    # Inject plugin registration if not already present
    unless File.read(target_css).include?("@plugin")
      inject_into_file target_css, after: '@import "tailwindcss";' do
        "\n@plugin \"@tailwindcss/typography\";"
      end
    end
  end
end