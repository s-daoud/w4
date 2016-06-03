class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @user = User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !session[:session_token].nil?
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out!
    session[:session_token] = nil
  end

  def check_logged_in
    if logged_in?
      true
    else
      redirect_to new_session_url
    end
  end
end
