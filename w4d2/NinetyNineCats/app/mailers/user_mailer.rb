class UserMailer < ApplicationMailer

  def welcome_email
    @user = "everybody@appacademy.io"
    @url = "http://localhost:3000/cats"
    mail(to: @user, subject: "Welcome!")
  end

end
