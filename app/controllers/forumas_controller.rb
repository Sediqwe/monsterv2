class ForumasController < ApplicationController
  before_action :set_foruma, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  # GET /forumas or /forumas.json
  def index
    @forumas = Foruma.all
  end

  # GET /forumas/1 or /forumas/1.json
  def show    
    dik = params[:page]
    dik = 1 if dik.nil?
    @uzenetek = Uzenet.where(foruma_id: params[:id]).order(created_at: :DESC).page(dik).per(10)
    @str = Foruma.find(params[:id]).forumf_id
    @forumf = Forumf.find(@str).title
  end

  # GET /forumas/new
  def new
    @foruma = Foruma.new
  end

  # GET /forumas/1/edit
  def edit
  end

  # POST /forumas or /forumas.json
  def create
    @foruma = Foruma.new(foruma_params)

    respond_to do |format|
      if @foruma.save
        format.html { redirect_to foruma_url(@foruma), notice: "Foruma was successfully created." }
        format.json { render :show, status: :created, location: @foruma }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @foruma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forumas/1 or /forumas/1.json
  def update
    respond_to do |format|
      if @foruma.update(foruma_params)
        format.html { redirect_to foruma_url(@foruma), notice: "Foruma was successfully updated." }
        format.json { render :show, status: :ok, location: @foruma }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @foruma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forumas/1 or /forumas/1.json
  def destroy
    @foruma.destroy

    respond_to do |format|
      format.html { redirect_to forumas_url, notice: "Foruma was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foruma
      @foruma = Foruma.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def foruma_params
      params.require(:foruma).permit(:title, :desc, :active, :user_id, :forumf_id,)
    end
end
