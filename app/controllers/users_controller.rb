class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
           session[:user_id] = @user.id
           @current_user ||= @user
           redirect_to tasks_path
        else
           flash[:notice] = @user.errors.full_messages
           redirect_to new_user_path
        end
    end

    def show
    end
    
    private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :avatar)
    end
end
