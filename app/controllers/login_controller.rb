class LoginController < ApplicationController
  def signin
    
  end
  
  def create
    
    @user = User.create(user_params)
    if @user.save
     redirect_to :sessions_new
    else
      flash[:error] = @user.errors.full_messages
      redirect_to login_reg_path
     
    end
  end
   
  
  def signout
    session[:user_id] = nil
    redirect_to root_url, notice: "Kilépés OK!"
  end

  def reg
     @user = User.new
  end


  private
  def user_params
   params.require(:user).permit(:name, :password, :password_confirmation, :email, :alias)
  end

end
