class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  require 'rmagick'
  
  def index
    @meta_title = "A gépi fordítások oldala! Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el közvetlenül a szerverről."
    @q = Game.ransack(params[:q])
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


  def show
    Game.default_timezone = :utc
    @user = Game.friendly.find(params[:id])
    @mega = Mega.where(game: @user.id)
    @uzenetek = Uzenet.where(game_id: @user.id).order(id: :DESC)
    @meta_description = @user.name + " gépi fordítása \n Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el közvetlenül a szerverről."
    
    
    
  end


  def new
    @game = Game.new
    
  end


  def edit
   
  end

  
  def create
    
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    respond_to do |format|
      if @game.save
        record_activity("Új játék felvéve: #{@game.name}")

        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
       
      else
        format.html { render :new, status: :unprocessable_entity }
       
      end
    end
  end

  
  def update
    upd = @game.updated_at
    respond_to do |format|
      record_activity("Játék módosítva - Előtte: #{@game.name}")
      if @game.update(game_params)
        record_activity("Játék módosítva - Utána: #{@game.name}")
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }        
      else
        format.html { render :edit, status: :unprocessable_entity }        
      end
    end
  end
 
    def downloadend
      ActiveStorage::Blob
      adat = Upload.find(params[:id])
      redirect_to root_path unless adat.game_files.attached?
      Game.default_timezone = :utc
      i = Download.new
      i.game_id = adat.game_id
      i.upload_id = adat.id
      i.ip_address = request.remote_ip
      i.save  
      send_data adat.game_files.blob.download, type: adat.game_files.content_type
    end
    def lobot
      data = je_params[:id]
      if data.to_s == session[:randoms].to_s
        render json: { info: 'ok' }
      else
        render json: { info: 'nok' }
      end
    end
    def download_file
      o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      string = (0...5).map { o[rand(o.length)] }.join
      if !cookies[:randoms]
        session[:randoms] = nil
      end
      if session[:randoms].blank?
        #Ha nincs randoms, hozzuk létre
        session[:randoms] = string
        cookies[:randoms] = {
        value: "times",
        expires: 1.minute.from_now
        }        
      end
      r = rand(0..255)
      g = rand(0..255)
      b = rand(0..255)
      random_color = "rgb(#{r}, #{g}, #{b})"
      original_color = random_color # Ezt az értéket a valódi színre kell állítani
      target_color = "rgb(#{g}, #{b}, #{r})"
      gradient_height = 200
      gradient = Magick::GradientFill.new(0, 0, 0, gradient_height, original_color, target_color)
      @adat = Upload.find(params[:id])
      canvas = Magick::Image.new(300, 100, gradient) { |options| options.background_color = random_color}
      gc = Magick::Draw.new 
      gc.pointsize(40)
      
      r = rand(0..255)
      g = rand(0..255)
      b = rand(0..255)
      text_color = "rgb(#{r}, #{g}, #{b})"
      font_styles = [Magick::NormalStyle, Magick::ItalicStyle, Magick::ObliqueStyle]
      random_font_style = font_styles.sample
      gc.font_style(random_font_style)
      gc.fill(text_color)
      gc.font_size(rand(20..30))
      gc.text(rand(30..60),rand(30..70), session[:randoms].center(rand(20)))
      gc.draw(canvas)
      randi = rand().to_s
      canvas.write('public/vedelem/' + randi + '.png')
      session[:random] = randi
    end
    
   
  
  def destroy
    
      record_activity("Játék eltávolítva: #{@game.name}")
      @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      
    end
  end

  private
    
    def set_game
      @game = Game.friendly.find(params[:id])
    end

    
    def game_params
      params.require(:game).permit(:name, :link_steam, :link_epic, :link_other, :description, :image, :link_hun)
    end

    def je_params
      params.require(:product).permit(:id, :done )
    end
   
end
