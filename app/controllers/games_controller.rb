class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]
  before_action :authorized?, only: %i[new edit update destroy]
  require 'rmagick'
  def index
    stored_number = cookies[:selected_number]
    @adatok = ["green", "pro", "purple", "contrast", "javascript", "typescript", "angular", "firebase", "vue", "rxjs", "node", "cloud-functions", "flutter", "google-maps", "android", "stripe", "machine-learning", "python", "svelte", "react", "ios", "minimum-viable-product", "mvp", "ionic", "nest", "graphql", "electron"]
    @q = Game.where(hidden: false).ransack(params[:q])
    
      if cookies[:selected_number].present?
        @number = cookies[:selected_number]
      end
    
    @games = @q.result(distinct: true).order('uploaded_at DESC').page(params[:page]).per(@number)
    @meta_description = "A gépi fordítások oldala! Közvetlen elérés a legnagyobb fordítás fájlokhoz is! Már #{Game.all.size} játékhoz, #{(Upload.all.size + Mega.all.size)} fordítás érhető el."
    @meta_image = "https://gep.monster/1.png"
   
  end
  def oldal
    selected_number = params[:selected_number]
    cookies.delete(:selected_number)
    # Létrehozzuk a cookie-t
    cookies[:selected_number] = {
      value: selected_number,
      expires: 31.day.from_now, # A cookie lejárati ideje, például 1 óra múlva
      same_site: :strict # Szigorú SameSite beállítás a biztonság érdekében
    }

    head :ok # Válasz a kérésre, 200-as státusszal
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
  def check_username
    username = params[:username].downcase
    user = User.find_by("LOWER(name) = :username OR LOWER(alias) = :username", username: username)
    ban = false
    if user
      ban = true
    else
      ban = false
    end
    if username == "admin" || username == "moderator"
      ban = true
    end
    if current_user.present?
      ban = false
    end
    if ban==false
      render json: { exists: false }
    else
      render json: { exists: true }
    end
  end



 
  def forumaccept
    
    if current_user.admin?
      gamemessage = Gamemessage.find(params[:id])
      gamemessage.accept = true
      gamemessage.save
      game = Game.find(gamemessage.game_id)
      if  gamemessage.user_id.present?
        name = gamemessage.user.alias || gamemessage.user.name
      else
        name = gamemessage.username
      end
      gemorss = Gemorss.create(link: "https://gep.monster/games/" + game.slug, user: name , desc: gamemessage.message, idouj3:gamemessage.created_at.strftime("%Y.%m.%d %H:%M"))
      redirect_to game_path(gamemessage.game_id)
    end
  end
  #Azért van kettő, mert egyik a game#SHOW a másik a DISQUS#index ből jön, és oda is tér vissza
  def forumaccept2
    if current_user.admin?
      gamemessage = Gamemessage.find(params[:id])
      gamemessage.accept = true
      gamemessage.save
      game = Game.find(gamemessage.game_id)
      if  gamemessage.user_id
        name = gamemessage.user.alias || gamemessage.user.name
      else
        name = gamemessage.username
      end
      gemorss = Gemorss.create(link: "https://gep.monster/games/" + game.slug, user: name , desc: gamemessage.message, idouj3:gamemessage.created_at.strftime("%Y.%m.%d %H:%M"))
      redirect_to disqus_path
    end
  end
  def forumdelete
    if current_user.admin?
      gamemessage = Gamemessage.find(params[:id])
      gamemessage.destroy()
      redirect_to game_path(gamemessage.game_id)
    end
  end
  def mute
    if current_user&.admin?
      user = User.find(params[:id])
      user.update(mute: true)     
    end
  end
  def unmute
    if current_user&.admin?
      user = User.find(params[:id])
      user.update(mute: false)      
    end
  end
  def forum
    duma = params[:duma] # Az űrlapból kapott duma_ID
    id = params[:id] 
    azon = params[:azon]
    username = params[:username] 
    gamemessageid= params[:reply]
    reply= false
    if gamemessageid.present?
      reply = true
    end
    

    game = Game.find(id)# Az űrlapból kapott id
    van = Gamemessage.find_by(azon: azon)
    if !van
      if current_user.present?
        adatok = Gamemessage.new(message: duma, user: current_user, game_id: game.id, azon: username + azon, reply: reply, gamemessage_id: gamemessageid)        
        adatok.accept= true
        if adatok.save
          if current_user.mute == false
            
            username = current_user.alias || current_user.name
            gemorss = Gemorss.create(link: "https://gep.monster/games/" + game.slug, user: username , desc: duma, idouj3:DateTime.now.strftime("%Y.%m.%d %H:%M"))
            ApplicationMailer.new_email(1).deliver
          end
        end
      else
        adatok = Gamemessage.new(message: duma, username: username, game_id: game.id, user_id: nil, azon: username + azon, reply: reply, gamemessage_id: gamemessageid)
        if adatok.save
        ApplicationMailer.new_email(1).deliver
        end
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
  def reset_game_genres
    if current_user.admin?
      GameGenre.delete_all
      Genre.delete_all
      redirect_to root_path, notice: "Game genres and genres have been reset."
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
    @gamemessage = Gamemessage.where(game_id: @user.id).order(id: :DESC)
    if @user.link_steam.present? && @user.link_steam.include?("steampowered.") && @user.game_genres.empty?
        require 'nokogiri'
        require 'open-uri'

        url = @user.link_steam
        doc = Nokogiri::HTML(URI.open(url))

        game = @user
        genres_hu = doc.css('.app_tag').map(&:text).map(&:strip)        
        genres_hu.each do |genre_hu|
          if genre_hu != "..." &&  genre_hu != "+"
            Genre.find_or_create_by(name_en: genre_hu)
          end
        end
        genres_hu.each_with_index do |genre_en,index|
          if index<4
            genre = Genre.find_by(name_en: genre_en)
            GameGenre.find_or_create_by(game: game, genre: genre)
          end
        end
        min_req = doc.at('div[data-os="win"] .game_area_sys_req_leftCol ul.bb_ul')
    rec_req = doc.at('div[data-os="win"] .game_area_sys_req_rightCol ul.bb_ul')

    def extract_text(node, selector, index)
      element = node&.at("#{selector}:nth-child(#{index})")
      element ? element.text.split(':').last.strip : 'N/A'
    end

    game.create_system_requirement(
      min_os: extract_text(min_req, 'li', 2),
      min_processor: extract_text(min_req, 'li', 3),
      min_memory: extract_text(min_req, 'li', 4),
      min_graphics: extract_text(min_req, 'li', 5),
      min_directx: extract_text(min_req, 'li', 6),
      min_storage: extract_text(min_req, 'li', 7),
      min_sound_card: extract_text(min_req, 'li', 8),
      rec_os: extract_text(rec_req, 'li', 2),
      rec_processor: extract_text(rec_req, 'li', 3),
      rec_memory: extract_text(rec_req, 'li', 4),
      rec_graphics: extract_text(rec_req, 'li', 5),
      rec_directx: extract_text(rec_req, 'li', 6),
      rec_storage: extract_text(rec_req, 'li', 7),
      rec_sound_card: extract_text(rec_req, 'li', 8)
    )
      
    end
    @system_requirement = @user.system_requirement

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
    if game_params[:stipi].present?
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
def yttodiscord
  yt = Youtubevideo.where(discord: false).order(id: :asc).limit(1).first;
  
  if yt
    yt.discord = true
    yt.save
    yt_user = User.find(yt.user_id)
    ytuser = yt_user.alias || yt_user.name
    yt_game = Game.find(yt.game_id)
    render html: (yt.link + "||||Ł" + yt_game.name.to_s + "||||Ł" + "https://gep.monster/games/" + yt_game.slug.to_s )
  else
    render html: ("")
  end
end
def discord
  
end
def bot_reset
  
  adat = Upload.find(params[:id])
  if current_user.id == adat.user_id && adat.special
    adat.update(special: false)
    record_activity("BOT RESET: #{adat.game_id} , #{adat.user.name}")
    redirect_to game_path(adat.game.slug)
  end
end
def windows_compatible_file_name(filename)
  filename = filename.gsub(":", "_")
  filename = filename.gsub(" ", "_")
  filename = filename.gsub(".", "_")
  filename = filename.gsub("'", "")
  filename = filename.gsub("__", "_")
  return filename
end
def gupdate
  @all = Gupdate.where(active: [false, nil]).first
  user = @all.user.alias || @all.user.name
  render html: @all.content + "||||Ł" + url_for(@all.game.image) + "||||Ł" + Game.find(@all.game_id).slug + "||||Ł" + user
  @all.update(active: true)
end
  def update
    upd = @game.updated_at
    akt_game = Game.find(@game.id)
    respond_to do |format|
      record_activity("Játék módosítva: #{@game.name}")
      if @game.update(game_params)
        if game_params[:image].present?
          Gupdate.create(content: "Új kép lett feltöltve", user_id: current_user.id, game_id: @game.id)
        end
          image = @game.image
          filename, extension = image.filename.to_s.split('.')
          image.filename = windows_compatible_file_name(@game.name.to_s) + "." + extension.to_s
          image.save
          if akt_game.stipiusername.to_i != current_user.id
            if game_params[:stipi].present?
              @game.update(hatarido: DateTime.now + 3.days, stipiusername: current_user.id, okes: false )    
            end
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
    @hiddens = Game.where(hidden: true)
  end
  private
    
    def set_game
      if params[:id]!="favicon" && params[:id]!="check_name"
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
