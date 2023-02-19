class ForumfsController < ApplicationController
  before_action :set_forumf, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  # GET /forumfs or /forumfs.json
  def index
    dik = params[:page]
    dik = 1 if dik.nil?

    @forumfs = Forumf.all.page(dik).per(10)
  end

  # GET /forumfs/1 or /forumfs/1.json
  def show
    dik = params[:page]
    dik = 1 if dik.nil?
    @forumas = Foruma.where(forumf_id:  params[:id]).page(dik).per(10)
    
  end

  # GET /forumfs/new
  def new
    @forumf = Forumf.new
  end

  # GET /forumfs/1/edit
  def edit
  end

  # POST /forumfs or /forumfs.json
  def create
    @forumf = Forumf.new(forumf_params)

    respond_to do |format|
      if @forumf.save
        format.html { redirect_to forumf_url(@forumf), notice: "Forumf was successfully created." }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        
      end
    end
  end

  # PATCH/PUT /forumfs/1 or /forumfs/1.json
  def update
    respond_to do |format|
      if @forumf.update(forumf_params)
        format.html { redirect_to forumf_url(@forumf), notice: "Forumf was successfully updated." }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        
      end
    end
  end

  # DELETE /forumfs/1 or /forumfs/1.json
  def destroy
    @forumf.destroy

    respond_to do |format|
      format.html { redirect_to forumfs_url, notice: "Forumf was successfully destroyed." }
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forumf
      @forumf = Forumf.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forumf_params
      params.require(:forumf).permit(:title, :desc, :active)
    end
end
