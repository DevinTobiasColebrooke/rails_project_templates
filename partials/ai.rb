def setup_ai_configuration
  puts "🤖  Configuring AI Services..."
  
  config_content = <<~RUBY
    # config/initializers/ai_config.rb
    module AiConfig
  RUBY

  if @install_local
    # WSL 2 IP Detection Logic
    config_content += <<~RUBY
      # Detect Windows Host IP from WSL
      def self.detect_host_ip
        return 'localhost' unless File.exist?('/proc/version') && File.read('/proc/version').include?('Microsoft')
        ip = `grep nameserver /etc/resolv.conf | awk '{print $2}'`.strip
        ip.empty? ? 'localhost' : ip
      end

      # 1. Try to use the IP passed from the Batch script (fastest/safest)
      # 2. Fallback to auto-detection inside WSL
      WINDOWS_HOST = ENV.fetch('WINDOWS_HOST_IP') { detect_host_ip }
      
      LOCAL_LLM_URL = "http://\#{WINDOWS_HOST}:8080"
      LOCAL_EMBEDDING_URL = "http://\#{WINDOWS_HOST}:8081"
      LOCAL_MODEL_NAME = "Meta-Llama-3.1-8B-Instruct-Q8_0.guff"
    RUBY
  end

  if @install_gemini
    config_content += <<~RUBY
      GEMINI_API_KEY = Rails.application.credentials.dig(:google, :gemini_key)
    RUBY
  end

  config_content += "  end\n"
  create_file "config/initializers/ai_config.rb", config_content
end

def setup_ai_services
  if @install_gemini
    create_file "app/services/google_gemini_service.rb", <<~RUBY
      require "faraday"
      class GoogleGeminiService
        BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"
        def initialize(api_key: AiConfig::GEMINI_API_KEY)
          @api_key = api_key
        end
        def generate(prompt)
          # Placeholder implementation
        end
      end
    RUBY
  end

  if @install_local
    create_file "app/services/local_llm_service.rb", <<~RUBY
      require "openai"
      class LocalLlmService
        def initialize
          @client = OpenAI::Client.new(access_token: "x", uri_base: AiConfig::LOCAL_LLM_URL)
        end
        
        def chat(prompt, system_message: "You are a helpful assistant.")
          response = @client.chat(
            parameters: {
              model: AiConfig::LOCAL_MODEL_NAME,
              messages: [
                { role: "system", content: system_message },
                { role: "user", content: prompt }
              ],
              temperature: 0.7
            }
          )
          response.dig("choices", 0, "message", "content")&.strip
        rescue => e
          Rails.logger.error "Local LLM Error: \#{e.message}"
          "Error connecting to Windows Local Host"
        end
      end
    RUBY
  end

  if @install_rag
    # Generate RAG services (Ferrum, pgvector migration)
    generate :migration, "EnableVectorExtension"
    migration_file = Dir.glob("db/migrate/*_enable_vector_extension.rb").first
    inject_into_file migration_file, after: "def change\n" do
      "    enable_extension 'vector'\n"
    end if migration_file
  end
end