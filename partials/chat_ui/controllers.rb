def setup_chat_controllers
  # 1. Conversations Controller
  create_file "app/controllers/conversations_controller.rb", <<~RUBY
    class ConversationsController < ApplicationController
      layout "chat" # Use specific chat layout

      def index
        @conversations = Conversation.order(updated_at: :desc)
        @conversation = Conversation.new
      end

      def create
        @conversation = Conversation.create
        redirect_to conversation_path(@conversation)
      end

      def show
        @conversation = Conversation.find(params[:id])
        @messages = @conversation.messages.order(:created_at)
      end

      def destroy
        Conversation.find(params[:id]).destroy
        redirect_to conversations_path
      end
    end
  RUBY

  # 2. Messages Controller
  # We construct the logic based on what AI services are installed
  
  service_call_logic = if @install_recon
    <<~RUBY
      # Call Recon Agent directly
          # We adapt the orchestrator to return a hash
          orchestrator = Recon::AutonomousOrchestrator.new(user_content, history: history.as_json)
          result = orchestrator.call
          
          # Normalize result
          content = result[:report] || result[:error] || "No response."
          logs = result[:logs] || []
    RUBY
  elsif @install_local
    <<~RUBY
      # Call Local LLM Service
          service = LocalLlmService.new
          # Format history for LLM
          formatted_history = history.map { |m| { role: m.role, content: m.content } }
          
          content = service.chat(user_content, system_message: "You are a helpful assistant.")
          logs = []
    RUBY
  else
    <<~RUBY
      # Echo / Dummy Service
          content = "Echo: \#{user_content} (No AI Service Configured)"
          logs = [{ "time" => Time.now.to_s, "msg" => "Echo response generated." }]
    RUBY
  end

  create_file "app/controllers/messages_controller.rb", <<~RUBY
    class MessagesController < ApplicationController
      def create
        @conversation = Conversation.find(params[:conversation_id])
        user_content = params[:content]

        return head :unprocessable_entity if user_content.blank?

        # 1. Save User Message
        @conversation.messages.create!(role: "user", content: user_content)

        # 2. Get recent history (limit context window)
        history = @conversation.messages.where.not(id: nil).order(:created_at).limit(20)

        # 3. Call AI Service (Async recommended for production, sync for demo)
        #{service_call_logic}

        # 4. Save Response
        @conversation.messages.create!(role: "assistant", content: content, metadata: { logs: logs })

        head :ok
      end
    end
  RUBY
end