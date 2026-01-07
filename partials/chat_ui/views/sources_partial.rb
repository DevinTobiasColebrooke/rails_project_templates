def setup_chat_view_sources_partial
  create_file "app/views/messages/_sources.html.erb", <<~ERB
    <% if sources.any? %>
      <div class="mt-5 pt-4 border-t border-gray-800">
        <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3 flex items-center gap-2">Verified Sources</h4>
        <div class="grid grid-cols-1 gap-2">
          <% sources.each do |url| %>
            <a href="<%= url %>" target="_blank" class="flex items-center gap-3 p-3 rounded-lg bg-gray-800/50 hover:bg-gray-800 border border-gray-800 no-underline">
              <div class="flex-1 min-w-0">
                <div class="truncate text-indigo-400 font-medium text-sm"><%= URI.parse(url).host %></div>
                <div class="truncate text-xs text-gray-600"><%= url %></div>
              </div>
            </a>
          <% end %>
        </div>
      </div>
    <% end %>
  ERB
end