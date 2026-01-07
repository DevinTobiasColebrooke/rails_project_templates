def setup_chat_view_helpers
  inject_into_file "app/helpers/application_helper.rb", after: "module ApplicationHelper\n" do
    <<~RUBY
      def markdown(text)
        return "" if text.blank?
        renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false)
        options = { autolink: true, tables: true, fenced_code_blocks: true }
        Redcarpet::Markdown.new(renderer, options).render(text).html_safe
      end

      def parse_markdown_with_sources(text)
        return [ text, [] ] if text.blank?
        if text.include?("## Sources")
          content, sources_part = text.split("## Sources", 2)
          sources = sources_part.scan(%r{https?://\\S+}).map { |url| url.gsub(/[).,;]+$/, "") }.uniq
          [ content, sources ]
        else
          [ text, [] ]
        end
      end
    RUBY
  end
end