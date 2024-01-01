class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  require 'rmagick'
  
  def index
    @q = Game.where(hidden: false).ransack(params[:q])
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
    @games = @q.result(distinct: true).order('uploaded_at DESC').page(params[:page]).per(session[:page_n])
    @meta_description = "A gépi fordítások oldala! Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el."
    @meta_image = "https://gep.monster/1.png"
   
  end
  def has_images_upload?(game_id)
    game = Game.find(game_id)
    game.uploads.joins(:pictures).exists?
  end
  def magyhu
    game = Game.find(params[:id])
    upd = game.updated_at
    if params[:type] == "van"
      game.done = true
    else
     game.done=false  
    end
    game.save

  end
  def feloldas
    game = Game.find(params[:id])
    stipi = Stipi.new(user_id: current_user.id, gamename: game.name, desc: params[:adat])
    stipi.save
    teszt = Upload.where(game_id: params[:id]).first
    game.stipi = false  
    game.save
    if teszt.nil?
      game.destroy      
    end
  end
  
  def new_yt
    if current_user&.admin? || current_user&.moderator?
      yt = Youtubevideo.create(game_id: je_params[:id], link: je_params[:done], user_id: current_user.id)
      yt.save
    end
  
  end
  def edit_yt
    id = je_params[:id]
    ytvideo = Youtubevideo.find(je_params[:id])
    if ytvideo.user == current_user
      if current_user&.admin? || current_user&.moderator?
        Youtubevideo.where(id: je_params[:id]).update(link: je_params[:done])
      end
    end
  end

  def delete_yt
    id = je_params[:id]
    p id
    ytvideo = Youtubevideo.find(id)
    p ytvideo.inspect
    if ytvideo.user_id == current_user.id
      if current_user&.admin? || current_user&.moderator?
        Youtubevideo.where(id: id).update(ready: false)
        
      end
    end
  end
  
  def show
    Game.default_timezone = :utc
    @user = Game.friendly.find(params[:id])
    @mega = Mega.where(game: @user.id)
    @uzenetek = Uzenet.where(game_id: @user.id).order(id: :DESC)
    @meta_description = @user.name + " gépi fordítása \n Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el."
    @autoforditoilista = Autoforditoilist.where(game_id:  @user.id)
    @meta_image = rails_blob_path(@user.image, only_path: true)
    @ytvideo = Youtubevideo.where(game_id: @user.id).where(ready: true).order("RANDOM()")
    
  end


  def new
    @game = Game.new
    
  end
  def check_name
    name = params[:name].downcase
    game = Game.find_by('LOWER(name) = ?', name)
    render json: { exists: !game.nil? }
  end
  def check_steam
    name = params[:name]
    game = Game.find_by(link_steam: name)
    render json: { exists: !game.nil? }
  end
  def edit
   
  end

  
  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    @game.uploaded_at = DateTime.now
    @game.hidden = true
    if !game_params[:stipi].nil?
      @game.hatarido = DateTime.now + 3.days
      @game.stipiusername = current_user.id
    end
    respond_to do |format|
      if @game.save
        record_activity("Új játék felvéve: #{@game.name}")
          image = @game.image
          filename, extension = image.filename.to_s.split('.')
          image.filename = windows_compatible_file_name(@game.name.to_s) + "." + extension.to_s
          image.save
     
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
       
      else
        format.html { render :new, status: :unprocessable_entity }
       
      end
    end
  end
def discord
  
end
def bot_reset
  adat = Upload.find(params[:id])
  adat.update(special: false)
  redirect_to game_path(adat.game.slug)
end
def windows_compatible_file_name(filename)
  filename = filename.gsub(":", "_")
  filename = filename.gsub(" ", "_")
  filename = filename.gsub(".", "_")
  filename = filename.gsub("'", "")
  filename = filename.gsub("__", "_")
  return filename
end
  def update
    upd = @game.updated_at
    respond_to do |format|
      record_activity("Játék módosítva - Előtte: #{@game.name}")
      if @game.update(game_params)
          image = @game.image
          filename, extension = image.filename.to_s.split('.')
          image.filename = windows_compatible_file_name(@game.name.to_s) + "." + extension.to_s
          image.save
          if game_params[:stipi]
            @game.update(hatarido: DateTime.now + 3.days, stipiusername: current_user.id, okes: false )    
          else
            @game.update(hatarido: DateTime.now + 3.days, stipiusername: current_user.id )
          end
        record_activity("Játék módosítva - Utána: #{@game.name}")
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }        
      else
        format.html { render :edit, status: :unprocessable_entity }        
      end
    end
  end
  
  def download
    i = Download.new
    session[:calm_down] = Time.now + 20.seconds
    i.game_id = je_params[:id]
    i.upload_id = je_params[:done]
    if i.save
      render json: { valami: 'OK' }
    else
      render json: { valami: 'NOK' }
    end
   end

  
  def destroy
      record_activity("Játék eltávolítva: #{@game.name}")
      @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      
    end
  end
  def features
    Game.where("hatarido IS NOT NULL").where("hatarido + INTERVAL '3 days' < ?", Time.now).update_all(stipi: false)
    @games = Game.where(stipi: true).where("hatarido + INTERVAL '3 days' > ?", Time.now)
  end
  private
    
    def set_game
      if params[:id]!="favicon"
        @game = Game.friendly.find(params[:id])
      end
    end

    
    def game_params
      params.require(:game).permit(:name, :link_steam, :link_epic, :link_other, :description, :image, :link_hun, :stipi)
    end

    def je_params
      params.require(:product).permit(:id, :done )
    end
   
end
