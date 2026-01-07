def setup_theme_helpers
  create_file "app/helpers/theme_helper.rb", <<~RUBY
    module ThemeHelper
      def theme_css_variables
        themes = YAML.load_file(Rails.root.join('config/themes.yml'))
        current_theme = themes['default']
        css_lines = current_theme.map { |key, value| "--theme-\#{key}: \#{value};" }.join(" ")
        ":root { \#{css_lines} }".html_safe
      end
    end
  RUBY

  inject_into_file 'app/views/layouts/application.html.erb', in_before: "</head>" do
    "\n    <style><%= theme_css_variables %></style>\n"
  end
end