class GamereqsController < ApplicationController
  before_action :set_gamereq, only: %i[ show edit update destroy ]

  # GET /gamereqs or /gamereqs.json
  def index
    @gamereqs = Gamereq.where(valasz: nil)
  end

  # GET /gamereqs/1 or /gamereqs/1.json
  def show
    @gamereqs = Gamereq.where(valasz: params[:id])
  end
  def gamereqsnew
    
  end
  def reqsaccept
    if current_user&.admin?

    end
  end
  def reqsdelete
    if current_user&.admin?
    end
  end
  # GET /gamereqs/new
  def new
    @gamereq = Gamereq.new
  end

  # GET /gamereqs/1/edit
  def edit
  end

  # POST /gamereqs or /gamereqs.json
  def create
    @gamereq = Gamereq.new(gamereq_params)

    respond_to do |format|
      if @gamereq.save
        format.html { redirect_to gamereq_url(@gamereq), notice: "Gamereq was successfully created." }
        format.json { render :show, status: :created, location: @gamereq }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gamereq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gamereqs/1 or /gamereqs/1.json
  def update
    respond_to do |format|
      if @gamereq.update(gamereq_params)
        format.html { redirect_to gamereq_url(@gamereq), notice: "Gamereq was successfully updated." }
        format.json { render :show, status: :ok, location: @gamereq }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gamereq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gamereqs/1 or /gamereqs/1.json
  def destroy
    @gamereq.destroy

    respond_to do |format|
      format.html { redirect_to gamereqs_url, notice: "Gamereq was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gamereq
      @gamereq = Gamereq.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gamereq_params
      params.require(:gamereq).permit(:gamename, :gamelink, :username)
    end
end
