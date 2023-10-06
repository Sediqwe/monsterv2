class SupportersController < ApplicationController
  before_action :set_supporter, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]
  # GET /supporters or /supporters.json
  def index
    @supporters = Supporter.all
  end

  # GET /supporters/1 or /supporters/1.json
  def show
  end

  # GET /supporters/new
  def new
    @supporter = Supporter.new
  end

  # GET /supporters/1/edit
  def edit
  end

  # POST /supporters or /supporters.json
  def create
    @supporter = Supporter.new(supporter_params)

    respond_to do |format|
      if @supporter.save
        format.html { redirect_to supporter_url(@supporter), notice: "Supporter was successfully created." }
        format.json { render :show, status: :created, location: @supporter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supporters/1 or /supporters/1.json
  def update
    respond_to do |format|
      if @supporter.update(supporter_params)
        format.html { redirect_to supporter_url(@supporter), notice: "Supporter was successfully updated." }
        format.json { render :show, status: :ok, location: @supporter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supporters/1 or /supporters/1.json
  def destroy
    @supporter.destroy

    respond_to do |format|
      format.html { redirect_to supporters_url, notice: "Supporter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supporter
      @supporter = Supporter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supporter_params
      params.require(:supporter).permit(:name, :datum, :euro)
    end
end
