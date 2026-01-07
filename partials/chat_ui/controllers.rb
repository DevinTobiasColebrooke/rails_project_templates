def setup_chat_controllers
  # 1. Conversations Controller
  # Adjust scope based on Auth presence
  
  if @install_auth
    conv_scope = "current_user.conversations"
  else
    conv_scope = "Conversation"
  end

  create_file "app/controllers/conversations_controller.rb", <<~RUBY
    class ConversationsController < ApplicationController
      layout "chat" # Use specific chat layout

      def index
        @conversations = #{conv_scope}.order(updated_at: :desc)
        @conversation = Conversation.new
      end

      def create
        @conversation = #{conv_scope}.create
        redirect_to conversation_path(@conversation)
      end

      def show
        # Security check if auth is on
        @conversation = #{conv_scope}.find(params[:id])
        @messages = @conversation.messages.order(:created_at)
      end

      def destroy
        #{conv_scope}.find(params[:id]).destroy
        redirect_to conversations_path
      end
    end
  RUBY

  # 2. Messages Controller
  message_lookup = @install_auth ? "current_user.conversations.find(params[:conversation_id])" : "Conversation.find(params[:conversation_id])"

  create_file "app/controllers/messages_controller.rb", <<~RUBY
    class MessagesController < ApplicationController
      def create
        @conversation = #{message_lookup}
        
        if @conversation.chat(params[:content])
          head :ok
        else
          head :unprocessable_entity
        end
      end
    end
  RUBY
end