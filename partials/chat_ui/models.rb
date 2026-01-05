def setup_chat_models
  # 1. Generate Models via Rails generator to ensure timestamps/ids
  generate :model, "Conversation title:string"
  generate :model, "Message conversation:references role:string content:text metadata:jsonb"

  # 2. Update Conversation Logic
  create_file "app/models/conversation.rb", <<~RUBY, force: true
    class Conversation < ApplicationRecord
      has_many :messages, dependent: :destroy
      
      # Default title
      before_create -> { self.title ||= "Research \#{Time.current.strftime('%m/%d %H:%M')}" }
    end
  RUBY

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