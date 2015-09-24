class UserMailer < ApplicationMailer
  default from: 'hello@mybrary.com'

  def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "Welcome #{@user.name}")
  end
end
