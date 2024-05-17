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
    message = Gamemessage.last
    @slug = Game.find(message.game_id).slug
    if message.user_id.present?
      @name = message.user.alias || message.user.name
    else
      @name = message.username
    end

    @duma = message.message
    mail(to: 'sediqwe@gmail.com', subject: 'Új üzenet')
  end
end
