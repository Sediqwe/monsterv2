class User2sController < ApplicationController
  before_action :set_user2, only: %i[ show edit update destroy ]
  before_action :authorized?
  before_action :admin?
  # GET /user2s or /user2s.json
  def index
    @user2s = User.all.order(name: :ASC)
  end

  # GET /user2s/1 or /user2s/1.json
  def show
  end

  # GET /user2s/new
  def new
    @user2 = User2.new
  end

  # GET /user2s/1/edit
  def edit
  end
  def translatertouser
    user = User.find(product_params[:id])
    user.translater_id = product_params[:data]
    user.save
  end
  # POST /user2s or /user2s.json
  def create
    @user2 = User2.new(user2_params)

    respond_to do |format|
      if @user2.save
        format.html { redirect_to user2_url(@user2), notice: "User2 was successfully created." }
        format.json { render :show, status: :created, location: @user2 }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user2s/1 or /user2s/1.json
  def update
    respond_to do |format|
      if @user2.update(user2_params)
        format.html { redirect_to user2_url(@user2), notice: "User2 was successfully updated." }
        format.json { render :show, status: :ok, location: @user2 }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user2s/1 or /user2s/1.json
  def destroy
    @user2.destroy

    respond_to do |format|
      format.html { redirect_to user2s_url, notice: "User2 was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user2
      @user2 = User2.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user2_params
      params.fetch(:user2, {})
    end
    def product_params
      params.require(:product).permit(:id, :data )
    end
end
