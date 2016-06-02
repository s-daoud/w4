class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.joins(:session_lists).where("session_lists.session_token = ?", session[:session_token]).first
  end
  def login!
    token = @user.session_lists.add_session_token(@user)
    session[:session_token] = token
    current_user
  end

  def redirect_user
    if current_user
      redirect_to root_url
    end
  end
end
