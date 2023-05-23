class FeltoltveController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  def index
       adat = Upload.where(special: [false, nil]).first
      if adat
          game = Game.find(adat.game_id)
          translater = Translater.find(adat.translater_id)
          adat.special = true
          adat.save
          render html: (adat.name + "||||Ł" + adat.version + "||||Ł" + game.slug + "||||Ł" + translater.translater_name  )
      else
      render html: ("")
      end
  end
end
