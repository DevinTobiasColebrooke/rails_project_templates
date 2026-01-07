def setup_root_route
  route 'root "home#index"'
end

def setup_admin_routes
  route <<~RUBY
    namespace :admin do
      root to: 'dashboard#index'
      resources :users
      resource :profile, only: [:edit, :update]
    end
  RUBY
end