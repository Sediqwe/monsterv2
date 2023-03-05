class ReinstallController < ApplicationController
  def index
    minden = Upload.all
    minden.each do |mi|
      adat = Game.find(mi.game_id)
        adat.updated_at = mi.created_at
        adat.save
      
    end
  end
  def game_up
    minden = Game.all
    minden.each do |mi|
      adat = mi.updated_at
      mi.update(uploaded_at: adat,updated_at: adat)
    end
  end
end
