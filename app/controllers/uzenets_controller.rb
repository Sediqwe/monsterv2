class UzenetsController < ApplicationController
  before_action :set_uzenet, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  # GET /uzenets or /uzenets.json
  def index
    @uzenets = Uzenet.all
  end

  # GET /uzenets/1 or /uzenets/1.json
  def show
  end

  # GET /uzenets/new
  def new
    @uzenet = Uzenet.new
  end
  def uzenet
    uzenet = Uzenet.new
    if uzenet_params[:desc].length > 1
      uzenet.desc = uzenet_params[:desc]
      uzenet.user_id = current_user.id
      uzenet.game_id = uzenet_params[:game_id]
      forum = Forum.where(gameid: uzenet_params[:game_id]).first
      forum.touch
      uzenet.save
      redirect_to game_path(uzenet_params[:game_id])
    end
  end
  # GET /uzenets/1/edit
  def edit
  end

  # POST /uzenets or /uzenets.json
  def create
    @uzenet = Uzenet.new(uzenet_params)
    @uzenet.user_id = current_user.id
    respond_to do |format|
      if @uzenet.save
        format.html { redirect_to foruma_path(id: @uzenet.foruma_id), notice: "Uzenet was successfully created." }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        
      end
    end
  end
  def delete_uzenet
    if current_user.admin?
      uzenet = Uzenet.find(params[:id])
      hello = uzenet.game_id
      uzenet.destroy
      redirect_to game_path(hello)
    else
      redirect_to game_path(hello)
    end
  end
  # PATCH/PUT /uzenets/1 or /uzenets/1.json
  def edit_uzenet
    @uzenet.update(uzenet_params)
    
  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uzenet
      @uzenet = Uzenet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def uzenet_params
      params.require(:product).permit(:desc, :game_id)
    end
end
