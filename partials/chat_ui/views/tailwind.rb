def setup_chat_view_tailwind
  css_files = ["app/assets/stylesheets/application.tailwind.css", "app/assets/tailwind/application.css"]
  target_css = css_files.find { |f| File.exist?(f) }

  if target_css
    unless File.read(target_css).include?("typography")
      if File.read(target_css).include?('@import "tailwindcss";')
        inject_into_file target_css, after: '@import "tailwindcss";' do
          "\n@plugin \"@tailwindcss/typography\";"
        end
      else
        append_to_file target_css, "\n@plugin \"@tailwindcss/typography\";"
      end
    end
  end
end