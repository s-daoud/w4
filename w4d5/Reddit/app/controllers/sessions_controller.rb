class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_creds(params[:user][:username], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["YOU ARE NOT A USER!! SORRY!!"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
