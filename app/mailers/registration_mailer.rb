class RegistrationMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: @user.email, subject: "#{@user.first_name}, Please activate your account")
  end
end
