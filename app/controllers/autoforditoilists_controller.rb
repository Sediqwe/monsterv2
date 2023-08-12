class AutoforditoilistsController < ApplicationController
  before_action :set_autoforditoilist, only: %i[ show edit update destroy ]

  # GET /autoforditoilists or /autoforditoilists.json
  def index
    @autoforditoilists = Autoforditoilist.all
  end

  # GET /autoforditoilists/1 or /autoforditoilists/1.json
  def show
  end

  # GET /autoforditoilists/new
  def new
    @autoforditoilist = Autoforditoilist.new
  end

  # GET /autoforditoilists/1/edit
  def edit
  end

  # POST /autoforditoilists or /autoforditoilists.json
  def create
    @autoforditoilist = Autoforditoilist.new(autoforditoilist_params)

    respond_to do |format|
      if @autoforditoilist.save
        format.html { redirect_to autoforditoilist_url(@autoforditoilist), notice: "Autoforditoilist was successfully created." }
        format.json { render :show, status: :created, location: @autoforditoilist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @autoforditoilist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /autoforditoilists/1 or /autoforditoilists/1.json
  def update
    respond_to do |format|
      if @autoforditoilist.update(autoforditoilist_params)
        format.html { redirect_to autoforditoilist_url(@autoforditoilist), notice: "Autoforditoilist was successfully updated." }
        format.json { render :show, status: :ok, location: @autoforditoilist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @autoforditoilist.errors, status: :unprocessable_entity }
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
      params.require(:autoforditoilist).permit(:game_id, :upload_id, :tipus, :active)
    end
end
