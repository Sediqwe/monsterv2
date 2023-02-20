class SessionsController < ApplicationController
  def new
    @upload = Upload.order("created_at DESC").first(10)
    @download = Download.order("created_at DESC").first(10)
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
