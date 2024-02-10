class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      flash[:notice] = "Login is invalid!"
      redirect_to root_path
    end
  end

    def destroy
      session[:user_id] = nil
      flash[:notice] = "You have been signed out!"
      redirect_to root_path
    end
end
