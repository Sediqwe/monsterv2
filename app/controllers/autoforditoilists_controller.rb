class AutoforditoilistsController < ApplicationController
  before_action :set_autoforditoilist, only: %i[ show edit update destroy ]
  def index
    @q1 = Autoforditoilist.ransack(params[:q])
    if params[:q] && params[:q].fetch(:gname_cont, "").size > 2
      @autoforditoilists = @q1.result(distinct: true)
    else      
      @autoforditoilists = Autoforditoilist.where(id: 0)
    end

    @xunity = Autoforditoilist.where(tipus: 1).order(gname: :ASC)
    @xunityf = Autoforditoilist.where(tipus: 3).order(gname: :ASC)
    @bep = Autoforditoilist.where(tipus: 2).order(gname: :ASC)
    @ransack_path = autoforditoilists_path
  end

  def show
  end

  def new
    @autoforditoilist = Autoforditoilist.new
    end

  def edit
  end

  def create
    @autoforditoilist = Autoforditoilist.new(autoforditoilist_params)
    @autoforditoilist.gname = Game.find(autoforditoilist_params[:game_id]).name
  
    respond_to do |format|
      if @autoforditoilist.save
        game = Game.find(autoforditoilist_params[:game_id])
        game.uploaded_at = DateTime.now
        game.save
        format.html { redirect_to autoforditoilist_url(@autoforditoilist), notice: "Autoforditoilist was successfully created." }
        format.json { render :show, status: :created, location: @autoforditoilist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @autoforditoilist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @autoforditoilist.update(autoforditoilist_params)
        format.html { redirect_to autoforditoilist_url(@autoforditoilist), notice: "Autoforditoilist was successfully updated." }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        
      end
    end
  end

  # DELETE /autoforditoilists/1 or /autoforditoilists/1.json
  def destroy
    @autoforditoilist.destroy

    respond_to do |format|
      format.html { redirect_to autoforditoilists_url, notice: "Autoforditoilist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_autoforditoilist
      @autoforditoilist = Autoforditoilist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def autoforditoilist_params
      params.require(:autoforditoilist).permit(:game_id, :tipus, :active)
    end
end
