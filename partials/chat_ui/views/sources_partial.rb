def setup_chat_view_sources_partial
  t = @chat_theme

  create_file "app/views/messages/_sources.html.erb", <<~ERB
    <% if sources.any? %>
      <div class="mt-4 pt-3 border-t border-dashed border-gray-400/30">
        <h4 class="text-[10px] font-bold uppercase tracking-wider mb-2 flex items-center gap-2 opacity-60">Verified Sources</h4>
        <div class="grid grid-cols-1 gap-1">
          <% sources.each do |url| %>
            <a href="<%= url %>" target="_blank" class="flex items-center gap-3 p-2 rounded-lg text-xs no-underline transition #{t[:message][:source_box]} #{t[:message][:source_link]}">
              <span class="truncate opacity-80 font-medium"><%= URI.parse(url).host rescue url %></span>
            </a>
          <% end %>
        </div>
      </div>
    <% end %>
  ERB
end