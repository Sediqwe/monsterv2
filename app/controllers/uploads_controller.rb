class UploadsController < ApplicationController
  before_action :set_upload, only: %i[ show edit update destroy ]
  before_action :authorized?
  
  # GET /uploads or /uploads.json
  def index
   @q = Upload.joins(:translater).order(game_id: :asc).ransack(params[:q])
    
    if params[:page_n].present?
      number = params[:page_n]
      session[:page_n] = number
      if number>"30"
        session[:page_n] = "30"
      end
      
    else
      if session[:page_n].nil?
        session[:page_n] = "30"
      end
    end
    @uploads = @q.result(distinct: true).order('created_at DESC').page(params[:page]).per(session[:page_n])
    
    
  end

  # GET /uploads/1 or /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end
  def editorka
    @upload = Upload.find(editor_params[:id])
    @upload.translater_id = editor_params[:adat]
    @upload.save
    
  end
  # GET /uploads/1/edit
  def edit
  end
  def bad
    @up = Upload.find(params[:id])
    if params[:type] == "ok"
      @up.bad = false
    else
      @up.bad = true  
    end
    @up.save()
    redirect_to game_path(params[:game])
    
    
  end
  def uploadrendezo
    upp = Upload.all.order(id: :ASC)
    upp.each do |up2|
      Uploadtranslater.create(upload_id: up2.id, translater_id: up2.translater_id)
    end
  end
  # POST /uploads or /uploads.json
  def create
    @upload = Upload.new(upload_params)
    @upload.translater_id = 5
    @upload.user_id = current_user.id
    @upload.datum = Date.today()
    @upload.name = Game.find(@upload.game_id).name
    @upload.bad = false
    upd = Game.find(@upload.game_id)
    upd.uploaded_at = DateTime.now
    upd.hidden = false
    if upd.stipi
      stipi = Stipi.new(user_id: current_user.id, gamename: upd.name, desc: "A játék elkészült, az adatlap feloldva.")
      stipi.save
    end
    upd.stipi = false
    upd.save
    
    respond_to do |format|
      if @upload.save
        params[:uploadtranslaters].each do |dorka|
          Uploadtranslater.create(upload_id: @upload.id , translater_id: dorka )
        end
        format.html { redirect_to game_url(@upload.game.slug), notice: "Sikeres feltöltés." }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end
  def plus_upload
    Upload.find(params[:id]).increment!(:sorrend)
    redirect_to game_path(Upload.find(params[:id]).game.slug)
  end
  def minus_upload
    Upload.find(params[:id]).decrement!(:sorrend)
    redirect_to game_path(Upload.find(params[:id]).game.slug)
  end
  # PATCH/PUT /uploads/1 or /uploads/1.json
  def update
    respond_to do |format|
      record_activity("Feltöltés módosítva - Előtte: #{@upload.inspect}")
      if @upload.update(upload_params)
        record_activity("Feltöltés módosítva - Utánna: #{@upload.inspect}, módosító: #{current_user.name}")        
        Uploadtranslater.where(upload_id: params[:id]).destroy_all
        params[:uploadtranslaters].each do |dorka|
          Uploadtranslater.create(upload_id: params[:id] , translater_id: dorka )
        end
        format.html { redirect_to game_url(@upload.game.slug), notice: "A feltöltés módosítva." }
        else
        format.html { render :edit, status: :unprocessable_entity }       
      end
    end
  end

  # DELETE /uploads/1 or /uploads/1.json
  def destroy
    record_activity("Feltöltés törlés: #{ Game.find(@upload.game_id).name} Version: #{@upload.version}")
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "A feltöltés törölve." }
      format.json { head :no_content }
    end
  end
  def picturesdelete
    if current_user.moderator? || current_user.admin?
      @upload = Upload.find(params[:upload_id]) # Vagy ahogyan a feltöltésed azonosítottad

      # Ellenőrizni kell, hogy a kép létezik-e a feltöltéshez kapcsolódva
      picture = @upload.pictures.find_by(id: params[:image_id])

      if picture.present?
        picture.purge # A kép törlése az aktuális feltöltéshez kapcsolódóan
        head :no_content # Válasz elküldése, nincs tartalommal
      else
        head :not_found # Ha a kép nem található, 404-es hibakód visszaküldése
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.require(:upload).permit(:name, :version, :description, :game_id, :game_files, :program_id , :platform_id, :link_mega, :mauto , :multiuser, :demo, pictures: [])
    end
    def editor_params
      params.require(:product).permit(:id, :adat )
    end
end
