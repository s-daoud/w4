class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if user.nil?
      @user = User.new(email: params[:user][:email], password: "")
      flash.now[:errors] = ["Can't find that username and/or password"]
      render :new
    else
      log_in_user!(user)
      user = current_user
      redirect_to user_url(user)
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
