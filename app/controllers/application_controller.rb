class ApplicationController < ActionController::Base
    # before_action :require_login
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format =~ %r{application/json} }
    helper_method :current_user

    def require_login
        redirect_to new_user_session_path unless session.include? :user_id
    end

    def current_user
       @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
