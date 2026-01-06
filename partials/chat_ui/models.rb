def setup_chat_models
  # 1. Generate Models via Rails generator
  # If Auth is installed, we associate conversations with users
  conv_cols = "title:string"
  conv_cols += " user:references" if @install_auth

  generate :model, "Conversation #{conv_cols}"
  generate :model, "Message conversation:references role:string content:text metadata:jsonb"

  # 2. Update Conversation Logic
  conversation_logic = <<~RUBY
    class Conversation < ApplicationRecord
      has_many :messages, dependent: :destroy
      #{'belongs_to :user' if @install_auth}
      
      # Default title
      before_create -> { self.title ||= "Research \#{Time.current.strftime('%m/%d %H:%M')}" }
    end
  RUBY

  create_file "app/models/conversation.rb", conversation_logic, force: true

  # 3. Update Message Logic
  create_file "app/models/message.rb", <<~RUBY, force: true
    class Message < ApplicationRecord
      belongs_to :conversation
      
      # Uses Turbo to auto-update the view
      after_create_commit -> { broadcast_append_to conversation, target: "messages" }
      
      validates :role, :content, presence: true
    end
  RUBY
end