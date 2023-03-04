class HowtosController < ApplicationController
  before_action :set_howto, only: %i[ show edit update destroy ]

  # GET /howtos or /howtos.json
  def index
    @howtos = Howto.all.order(poz: :ASC)
    @download = Download.order("created_at DESC").first(10)
    @upload = Upload.order("created_at DESC").first(10)
  end

  # GET /howtos/1 or /howtos/1.json
  def show
  end

  # GET /howtos/new
  def new
    @howto = Howto.new
  end

  # GET /howtos/1/edit
  def edit
  end

  # POST /howtos or /howtos.json
  def create
    @howto = Howto.new(howto_params)

    respond_to do |format|
      if @howto.save
        format.html { redirect_to howto_url(@howto), notice: "Howto was successfully created." }
        format.json { render :show, status: :created, location: @howto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @howto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /howtos/1 or /howtos/1.json
  def update
    respond_to do |format|
      if @howto.update(howto_params)
        format.html { redirect_to howto_url(@howto), notice: "Howto was successfully updated." }
        format.json { render :show, status: :ok, location: @howto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @howto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /howtos/1 or /howtos/1.json
  def destroy
    @howto.destroy

    respond_to do |format|
      format.html { redirect_to howtos_url, notice: "Howto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_howto
      @howto = Howto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def howto_params
      params.require(:howto).permit(:title, :description, :poz)
    end
end
