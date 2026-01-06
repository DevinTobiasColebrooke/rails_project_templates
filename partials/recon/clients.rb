def setup_recon_clients
  create_file "app/clients/local_llm_client.rb", <<~RUBY
    require "openai"
    require "json"

    class LocalLlmClient
      # Local Configuration
      # Defaults to the batch script ports (9090), but overridable via ENV
      BASE_URL = ENV.fetch("LLM_BASE_URL", "http://127.0.0.1:9090").freeze
      MODEL_NAME = ENV.fetch("LLM_MODEL_NAME", "default").freeze
      API_KEY = ENV.fetch("LLM_API_KEY", "dummy").freeze

      def initialize
        @client = OpenAI::Client.new(
          access_token: API_KEY,
          uri_base: BASE_URL,
          request_timeout: 120
        )
      end

      def chat(messages:, temperature: 0.0, json_mode: false)
        params = {
          model: MODEL_NAME,
          messages: messages,
          temperature: temperature
        }

        if json_mode
          params[:response_format] = { type: "json_object" }
          # Ensure system prompt asks for JSON to avoid model confusion
          unless messages.any? { |m| m[:role] == "system" && m[:content].downcase.include?("json") }
            if messages.first[:role] == "system"
              messages.first[:content] += " Respond strictly in valid JSON."
            end
          end
        end

        response = @client.chat(parameters: params)
        content = response.dig("choices", 0, "message", "content")

        raise "LLM returned empty response" if content.blank?
        content.strip
      rescue Faraday::ConnectionFailed
        Rails.logger.error "LocalLlmClient: Connection refused at \#{BASE_URL}"
        raise
      end

      def chat_with_tools(messages:, tools:, temperature: 0.0)
        params = {
          model: MODEL_NAME,
          messages: messages,
          tools: tools,
          tool_choice: "auto",
          temperature: temperature
        }

        response = @client.chat(parameters: params)
        message = response.dig("choices", 0, "message")

        if message["tool_calls"]
          # The API returns tool_calls as an array of hashes
          { tool_calls: message["tool_calls"] }
        else
          { content: message["content"]&.strip }
        end
      rescue Faraday::ConnectionFailed
        Rails.logger.error "LocalLlmClient: Connection refused at \#{BASE_URL}"
        raise
      end

      def healthy?
        chat(messages: [ { role: "user", content: "ping" } ])
        true
      rescue
        false
      end
    end
  RUBY
end