class UsersController < ApplicationController
  before_action :set_users, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[show, index, edit destroy update]
  
  # GET /users or /users.json
  def index
    
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @users = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @users = users.new(users_params)
    @users.user_id = current_user.id
    @users.active = true
    respond_to do |format|
      if @users.save
        format.html { redirect_to users_url(@users), notice: "A felhasználó létrehozva." }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(users_params)
        format.html { redirect_to edit_user_path(@user), notice: "A felhasználói adatok módosítva" }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @users.destroy

    respond_to do |format|
      format.html { redirect_to users_index_url, notice: "users was successfully destroyed." }
      
    end
  end
 
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_users
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def users_params
      params.require(:user).permit(:name, :email, :password, :alias,:moderator, :photo, :tam1, :tam2, :tam3, :tam4, :desc)
    end
end
