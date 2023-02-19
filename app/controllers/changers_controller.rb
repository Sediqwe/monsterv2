class ChangersController < ApplicationController
  before_action :set_changer, only: %i[ show edit update destroy ]

  # GET /changers or /changers.json
  def index
    @changers = Changer.all
  end

  # GET /changers/1 or /changers/1.json
  def show
  end

  # GET /changers/new
  def new
    @changer = Changer.new
  end

  # GET /changers/1/edit
  def edit
  end

  # POST /changers or /changers.json
  def create
    @changer = Changer.new(changer_params)

    respond_to do |format|
      if @changer.save
        format.html { redirect_to changer_url(@changer), notice: "Changer was successfully created." }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        
      end
    end
  end

  # PATCH/PUT /changers/1 or /changers/1.json
  def update
    respond_to do |format|
      if @changer.update(changer_params)
        format.html { redirect_to changer_url(@changer), notice: "Changer was successfully updated." }        
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /changers/1 or /changers/1.json
  def destroy
    @changer.destroy

    respond_to do |format|
      format.html { redirect_to changers_url, notice: "Changer was successfully destroyed." }      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_changer
      @changer = Changer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def changer_params
      params.require(:changer).permit(:ori, :mod)
    end
end
