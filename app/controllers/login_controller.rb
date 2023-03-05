class LoginController < ApplicationController
  def signin
    @upload = Upload.order("created_at DESC").first(5)
    @download = Download.order("created_at DESC").first(10)
  end
  
  def create
    @upload = Upload.order("created_at DESC").first(5)
    @download = Download.order("created_at DESC").first(10)
    @user = User.create(user_params)
    if @user.save
     redirect_to :sessions_new
    else
     render "reg"
    end
  end
   
  
  def signout
    session[:user_id] = nil
    redirect_to root_url, notice: "Kilépés OK!"
  end

  def reg
    @upload = Upload.order("created_at DESC").first(5)
    @download = Download.order("created_at DESC").first(10)
    @user = User.new
  end


  private
  def user_params
   params.require(:user).permit(:name, :password, :password_confirmation, :email, :alias)
  end

end
