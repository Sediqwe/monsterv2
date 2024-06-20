class BackupController < ApplicationController
  before_action :authorized?
  def index
    
    @backup = Game.all.order(name: :ASC)
    @links = []
    
    @backup.each do |game|
      game_link = {}
      game_link[:image_link] = rails_blob_url(game.image)
      game_files = []
    
      Upload.where(game_id: game.id).each do |upload|
        game_files << { filename: upload.game_files.filename, file_link: url_for(upload.game_files) }
      end
    
      game_link[:game_files] = game_files
      @links << game_link
    end
    send_data @links.join("\n"), filename: 'game_links.txt'

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
