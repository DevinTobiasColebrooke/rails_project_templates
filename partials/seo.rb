def setup_seo
  puts "🔍  Configuring SEO & Metadata..."

  # 1. Meta Tags Initializer
  create_file "config/initializers/meta_tags.rb", <<~RUBY
    MetaTags.configure do |config|
      config.title_limit        = 70
      config.description_limit  = 160
      config.keywords_limit     = 255
      config.keywords_separator = ', '
    end
  RUBY

  # 2. Inject into Layout
  # Replaces the default <title> tag with the dynamic one
  gsub_file 'app/views/layouts/application.html.erb', /<title>.*?<\/title>/, "<%= display_meta_tags site: 'MyApp' %>"

  # 3. Sitemap Config
  create_file "config/sitemap.rb", <<~RUBY
    # Set the host name for URL creation
    SitemapGenerator::Sitemap.default_host = "http://www.example.com"

    SitemapGenerator::Sitemap.create do
      # Put links creation logic here.
      #
      # The root path '/' and sitemap index file are added automatically for you.
      # Links are added to the Sitemap in the order they are specified.
      #
      # add pages_about_path, :changefreq => 'weekly'
      # add pages_contact_path, :changefreq => 'monthly'
    end
  RUBY
end