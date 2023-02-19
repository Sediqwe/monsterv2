class ScannersController < ApplicationController
  before_action :set_scanner, only: %i[ show edit update destroy ]

  # GET /scanners or /scanners.json
  def index
    @scanners = Scanner.all
  end

  # GET /scanners/1 or /scanners/1.json
  def show
  end

  # GET /scanners/new
  def new
    @scanner = Scanner.new
    @para = params[:id]
  end

  # GET /scanners/1/edit
  def edit
    @para = Scanner.find(params[:id]).beolva_id
  end

  # POST /scanners or /scanners.json
  def create
    @scanner = Scanner.new(scanner_params)

    respond_to do |format|
      if @scanner.save
        format.html { redirect_to scanner_url(@scanner), notice: "Scanner was successfully created." }
        format.json { render :show, status: :created, location: @scanner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scanner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scanners/1 or /scanners/1.json
  def update
    respond_to do |format|
      if @scanner.update(scanner_params)
        format.html { redirect_to scanner_url(@scanner), notice: "Scanner was successfully updated." }
        format.json { render :show, status: :ok, location: @scanner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scanner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scanners/1 or /scanners/1.json
  def destroy
    @scanner.destroy

    respond_to do |format|
      format.html { redirect_to scanners_url, notice: "Scanner was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scanner
      @scanner = Scanner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scanner_params
      params.require(:scanner).permit(:start, :stop, :beolva_id)
    end
end
