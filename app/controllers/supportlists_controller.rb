class SupportlistsController < ApplicationController
  before_action :set_supportlist, only: %i[ show edit update destroy ]

  # GET /supportlists or /supportlists.json
  def index
    @supportlists = Supportlist.where(user_id: current_user.id)
  end

  # GET /supportlists/1 or /supportlists/1.json
  def show
  end

  # GET /supportlists/new
  def new
    @supportlist = Supportlist.new
  end

  # GET /supportlists/1/edit
  def edit
  end

  # POST /supportlists or /supportlists.json
  def create
    @supportlist = Supportlist.new(supportlist_params)
    @supportlist.user_id = current_user.id
    respond_to do |format|
      if @supportlist.save
        format.html { redirect_to supportlists_path, notice: "Supportlist was successfully created." }
        format.json { render :show, status: :created, location: @supportlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supportlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supportlists/1 or /supportlists/1.json
  def update
    respond_to do |format|
      if @supportlist.update(supportlist_params)
        format.html { redirect_to supportlist_url(@supportlist), notice: "Supportlist was successfully updated." }
        format.json { render :show, status: :ok, location: @supportlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supportlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supportlists/1 or /supportlists/1.json
  def destroy
    @supportlist.destroy

    respond_to do |format|
      format.html { redirect_to supportlists_url, notice: "Supportlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supportlist
      @supportlist = Supportlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supportlist_params
      params.require(:supportlist).permit(:link, :name, :user_id, :active, :iconbootstrap)
    end
end
