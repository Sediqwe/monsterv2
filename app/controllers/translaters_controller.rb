class TranslatersController < ApplicationController
  before_action :set_translater, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  
  # GET /translaters or /translaters.json
  def index
    @translaters = Translater.where(active: true).all.order(translater_name: :ASC)
    @translaters_rest = Translater.where(active: false).order(translater_name: :ASC)
    
    @upload = Upload.order("created_at DESC").first(10)
    @download = Download.order("created_at DESC").first(10)
   
  end
  def active
    if current_user.admin?
      trans = Translater.find(params[:id])
      trans.update(active: true)
    end
  end
  def deactive
    if current_user.admin?
      trans = Translater.find(params[:id])
      trans.update(active: false)
    end
  end
  # GET /translaters/1 or /translaters/1.json
  def show
    
    @feltoltesek = Upload.where(translater_id: params[:id]).order(id: :DESC)
    @upload = Upload.order("created_at DESC").first(10)
    @download = Download.order("created_at DESC").first(10)
    translater = Translater.where(slug: params[:id]).first
    user = User.where(translater_id: translater.id).first
    if user      
      @supportlist = Supportlist.where(user_id: user)
    end
  end

  # GET /translaters/new
  def new
    @translater = Translater.new
  end

  # GET /translaters/1/edit
  def edit
  end
  
  # POST /translaters or /translaters.json
  def create
    @translater = Translater.new(translater_params)

    respond_to do |format|
      if @translater.save
        format.html { redirect_to translater_url(@translater), notice: "Translater was successfully created." }
        format.json { render :show, status: :created, location: @translater }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @translater.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /translaters/1 or /translaters/1.json
  def update
    respond_to do |format|
      if @translater.update(translater_params)
        format.html { redirect_to translater_url(@translater), notice: "Translater was successfully updated." }
        format.json { render :show, status: :ok, location: @translater }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @translater.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /translaters/1 or /translaters/1.json
  def destroy
    @translater.destroy

    respond_to do |format|
      format.html { redirect_to translaters_url, notice: "Translater was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def regen
    translaters = Translater.all

    # Iterál a rekordokon és hívja meg a generate_and_save_slug methodot mindegyikre
    translaters.each do |translater|
    translater.generate_and_save_slug
  end
end

#Ex:- :default =>''
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_translater
      @translater = Translater.friendly.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def translater_params
      params.require(:translater).permit(:translater_name)
    end
end
