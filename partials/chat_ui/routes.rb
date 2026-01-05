def setup_chat_routes
  route <<~RUBY
    resources :conversations do
      resources :messages, only: :create
    end
  RUBY
end