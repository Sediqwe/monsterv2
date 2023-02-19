class ReinstallController < ApplicationController
  def index
    minden = Upload.all
    minden.each do |mi|
      adat = Game.find(mi.game_id)
      if adat.updated_at < mi.created_at
        adat.updated_at = mi.created_at
        adat.save
      end
    end
  end
end
