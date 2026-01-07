def setup_recon_clients
  # Renamed to LlmClient (Model) to live in app/models
  create_file "app/models/llm_client.rb", <<~RUBY
    require "openai"
    require "json"

    class LlmClient
      include ActiveModel::Model

      # Local Configuration
      BASE_URL = ENV.fetch("LLM_BASE_URL", AiConfig::LOCAL_LLM_URL).freeze
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
          # Ensure prompt requests JSON
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
      rescue Faraday::ConnectionFailed, Faraday::TimeoutError => e
        handle_error(e)
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
          { tool_calls: message["tool_calls"] }
        else
          { content: message["content"]&.strip }
        end
      rescue Faraday::ConnectionFailed, Faraday::TimeoutError => e
        handle_error(e)
      end

      def healthy?
        chat(messages: [ { role: "user", content: "ping" } ])
        true
      rescue
        false
      end

      private

      def handle_error(e)
        Rails.logger.error "LlmClient Connection Failed: \#{e.message}"
        hint = (BASE_URL.include?("127.0.0.1") || BASE_URL.include?("localhost")) ? " (Check WSL/Host IP)" : ""
        raise "Connection to AI Server failed at \#{BASE_URL}\#{hint}. Ensure stack is running."
      end
    end
  RUBY
end