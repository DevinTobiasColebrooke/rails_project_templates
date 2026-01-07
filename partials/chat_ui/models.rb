def setup_chat_models
  # 1. Generate Models via Rails generator
  conv_cols = "title:string"
  conv_cols += " user:references" if @install_auth

  generate :model, "Conversation #{conv_cols}"
  generate :model, "Message conversation:references role:string content:text metadata:jsonb"

  # 2. Define AI Logic (Business Logic)
  # We create a Concern to handle the interaction with AI providers
  
  ai_logic_body = if @install_recon
    <<~RUBY
      # Call Recon Agent directly
      orchestrator = Recon::AutonomousOrchestrator.new(user_content, history: history_context)
      result = orchestrator.call
      
      {
        content: result[:report] || result[:error] || "No response.",
        logs: result[:logs] || []
      }
    RUBY
  elsif @install_local
    <<~RUBY
      # Call Local LLM via Net/HTTP (inline logic, no service object)
      require 'net/http'
      
      formatted_history = history_context.map { |m| { role: m.role, content: m.content } }
      
      uri = URI("\#{AiConfig::LOCAL_LLM_URL}/chat")
      http = Net::HTTP.new(uri.host, uri.port)
      
      request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
      request.body = { 
        messages: formatted_history << { role: "user", content: user_content },
        system: "You are a helpful assistant." 
      }.to_json
      
      response = http.request(request)
      json = JSON.parse(response.body) rescue {}
      
      {
        content: json.dig("content") || "Error connecting to AI.",
        logs: []
      }
    RUBY
  else
    <<~RUBY
      # Echo / Dummy Logic
      {
        content: "Echo: \#{user_content} (No AI Service Configured)",
        logs: [{ "time" => Time.now.to_s, "msg" => "Echo response generated." }]
      }
    RUBY
  end

  create_file "app/models/concerns/ai_chatting.rb", <<~RUBY
    module AiChatting
      extend ActiveSupport::Concern

      def chat(user_content)
        return false if user_content.blank?

        transaction do
          # 1. Save User Message
          messages.create!(role: "user", content: user_content)

          # 2. Generate Response
          response_data = generate_ai_response(user_content)

          # 3. Save Assistant Message
          messages.create!(
            role: "assistant", 
            content: response_data[:content], 
            metadata: { logs: response_data[:logs] }
          )
        end
        true
      end

      private

      def generate_ai_response(user_content)
        # Context Window
        history_context = messages.where.not(id: nil).order(:created_at).limit(20)

        #{ai_logic_body}
      end
    end
  RUBY

  # 3. Update Conversation Logic
  conversation_logic = <<~RUBY
    class Conversation < ApplicationRecord
      include AiChatting

      has_many :messages, dependent: :destroy
      #{'belongs_to :user' if @install_auth}
      
      before_create -> { self.title ||= "Research \#{Time.current.strftime('%m/%d %H:%M')}" }
    end
  RUBY

  create_file "app/models/conversation.rb", conversation_logic, force: true

  # 4. Update Message Logic
  create_file "app/models/message.rb", <<~RUBY, force: true
    class Message < ApplicationRecord
      belongs_to :conversation
      
      # Uses Turbo to auto-update the view
      after_create_commit -> { broadcast_append_to conversation, target: "messages" }
      
      validates :role, :content, presence: true
    end
  RUBY
end