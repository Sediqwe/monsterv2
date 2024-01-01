class BackupController < ApplicationController
  
  def index
    @backup = Game.all.order(name: :ASC)
  
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
