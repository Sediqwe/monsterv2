class BackupController < ApplicationController
  before_action :authorized?
  def index
    if current_user&.admin?
      @backup = Game.all.order(name: :ASC)
      @links = []
      
      @backup.each do |game|
        @links << rails_blob_url(game.image)
        Upload.where(game_id: game.id).each do |upload|
          @links << url_for(upload.game_files)
        end
        
      
      end
      send_data @links.join("\n"), filename: 'game_links.txt'
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
  def egyszer 
    games = Game.all

    # Minden elemhez végigmegyünk
        games.each do |game|
          # Megkapjuk az elem image fájljait
          image = game.image
          filename, extension = image.filename.to_s.split('.')
          image.filename = windows_compatible_file_name(game.name.to_s) + "." + extension.to_s
          image.save
          
        end
  end
  
end
