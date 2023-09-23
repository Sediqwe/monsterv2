class ApplicationMailer < ActionMailer::Base
  layout "mailer"
  default from: 'monstergep@gmail.com'

  def welcome_email(id)
    @user = User.find(id)

    mail(to: @user.email, subject: 'Welcome to our website!')
  end
end
