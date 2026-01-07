def setup_home_controller
  generate "controller", "home index --skip-routes"
end

def setup_admin_controllers
  # 1. Base Controller
  create_file "app/controllers/admin/base_controller.rb", <<~RUBY
    module Admin
      class BaseController < ApplicationController
        before_action :resume_session
        before_action :require_authentication
        # before_action :ensure_admin_privileges! # Implement based on your role logic
        
        layout 'admin'
      end
    end
  RUBY

  # 2. Dashboard Controller
  create_file "app/controllers/admin/dashboard_controller.rb", <<~RUBY
    module Admin
      class DashboardController < BaseController
        def index
        end
      end
    end
  RUBY

  # 3. Users Controller (User Management)
  create_file "app/controllers/admin/users_controller.rb", <<~RUBY
    module Admin
      class UsersController < BaseController
        before_action :set_user, only: [:edit, :update, :destroy]

        def index
          @users = User.order(created_at: :desc)
        end

        def new
          @user = User.new
        end

        def create
          @user = User.new(user_params)
          if @user.save
            redirect_to admin_users_path, notice: "User created successfully."
          else
            render :new, status: :unprocessable_entity
          end
        end

        def edit
        end

        def update
          # Handle password separately to allow blank update (keep existing password)
          if params[:user][:password].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
          end

          if @user.update(user_params)
            redirect_to admin_users_path, notice: "User updated successfully."
          else
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          if @user == current_user
            redirect_to admin_users_path, alert: "You cannot delete yourself."
          else
            @user.destroy
            redirect_to admin_users_path, notice: "User deleted."
          end
        end

        private

        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit(:email_address, :password, :password_confirmation)
        end
      end
    end
  RUBY

  # 4. Profile Controller (Self Management)
  create_file "app/controllers/admin/profiles_controller.rb", <<~RUBY
    module Admin
      class ProfilesController < BaseController
        def edit
          @user = current_user
        end

        def update
          @user = current_user
          
          # Allow updating without changing password if left blank
          if params[:user][:password].blank?
             params[:user].delete(:password)
             params[:user].delete(:password_confirmation)
          end

          if @user.update(user_params)
            redirect_to admin_root_path, notice: "Profile updated successfully."
          else
            render :edit, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:email_address, :password, :password_confirmation)
        end
      end
    end
  RUBY
end