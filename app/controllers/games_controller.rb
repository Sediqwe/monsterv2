class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy]
  require 'rmagick'
  
  def index
    if current_user
      if current_user.admin? || current_user.moderator?
        @q = Game.ransack(params[:q])
      else
        @q = Game.where(hidden: false).ransack(params[:q])
        
      end
    else
      @q = Game.where(hidden: false).ransack(params[:q])
    end
  
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
    @meta_description = @user.name + " gépi fordítása \n Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el."
    @autoforditoilista = Autoforditoilist.where(game_id:  @user.id)
    @meta_image = rails_blob_path(@user.image, only_path: true)
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
    if game_params[:stipi]
      @game.hatarido = DateTime.now + 3.days
    end
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
    @games = Game.where(stipi: true).where("hatarido + INTERVAL '3 days' > ?", Time.now)
  end
  private
    
    def set_game
      @game = Game.friendly.find(params[:id])
    end

    
    def game_params
      params.require(:game).permit(:name, :link_steam, :link_epic, :link_other, :description, :image, :link_hun, :stipi)
    end

    def je_params
      params.require(:product).permit(:id, :done )
    end
   
end
