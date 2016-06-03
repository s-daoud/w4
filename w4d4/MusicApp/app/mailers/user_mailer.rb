class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = "http://www.google.com"
    # "http://localhost:3000/users/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: "Please activate your account")
  end
end
