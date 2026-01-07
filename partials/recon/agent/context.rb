def setup_recon_context
  create_file "app/models/research_context.rb", <<~RUBY
    class ResearchContext
      include ActiveModel::Model

      # Cache HTML content for 24 hours
      TTL = 24.hours

      def initialize(org_name: nil)
        @org_name = org_name
        @local_memory = {}
      end

      def cache_page(url, content)
        return if content.blank?
        @local_memory[url] = content
        Rails.cache.write(cache_key(url), content, expires_in: TTL)
      end

      def get_page(url)
        @local_memory[url] || Rails.cache.read(cache_key(url))
      end

      private

      def cache_key(url)
        "recon_html/\#{Digest::MD5.hexdigest(url)}"
      end
    end
  RUBY
end