class SessionsController < ApplicationController
  before_action :redirect_user, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if @user.nil?
      redirect_to users_url
    else
      login!
      redirect_to cats_url
    end
  end

  def destroy
    if current_user
      fail
      current_user.session_lists.delete_session_token(session[:session_token])
      session[:session_token] = nil
    end
    redirect_to root_url
  end
end
