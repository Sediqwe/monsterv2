class SessionsController < ApplicationController
  def new
  
  end
  def recovery
  end
  def recovery_mail_sent
  end
  def sessions_recovery_mail
  user =  User.find_by(name: params[:session][:name].downcase)  
  if user
    user.recovery = SecureRandom.urlsafe_base64(20)
    user.save
    -ApplicationMailer.recovery_email(current_user.id).deliver
    redirect_to recovery_mail_sent_path(id: user.id)
  else
  
  end

  end
  def create
    
    user = User.find_by(name: user_params[:name].downcase).try(:authenticate, user_params[:password])
    if user
      session[:user_id] = user.id
      record_activity("Beléptetve: #{user.name} (ID:##{user.id})")
      redirect_to root_url, notice: "Belépve!"
    else
      sleep 10
      record_attempts("Hibás belépés")
      number = ActivityLog.find_by(ip_address: request.env['REMOTE_ADDR'])
     flash.now[:login_error] = "Hibás felhasználó / jelszó páros"
     
     render 'new'
    end
   end
   
   private
    def user_params
     params.require(:session).permit(:name, :password)
    end
end
