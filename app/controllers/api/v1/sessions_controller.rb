class Api::V1::SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      render json: {
        message: "Succcessfully Logined",
        user: @user }
    else
      render json: {
        message: "Login is invalid!",
        user: @user}
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {
      message: "You have been signed out!",
      user: @user }
  end
end
