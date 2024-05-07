class ApplicationMailer < ActionMailer::Base
  
  default from: 'monstergep@gmail.com'

  def welcome_email(id)
    @user = User.find(id)

    mail(to: @user.email, subject: 'Welcome to our website!')
  end
  def recovery_email(id)
    @user1 = User.find(id)

    mail(to: @user1.email, subject: 'Elfelejtett jelszó!')
  end
  def new_email(id)
    @user1 = User.find(1)
    mail(to: @user1.email, subject: 'Új üzenet')
  end
end
