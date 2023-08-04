class FeltoltveController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  def index
       adat = Upload.where(special: [false, nil]).first
      if adat
          game = Game.find(adat.game_id)
          translater = Uploadtranslater.where(upload_id: adat.id)
          trn = ""
          p translater.inspect
          translater.each_with_index do |dorka, index|
            trn_name = Translater.find(dorka.translater_id)
            if index < translater.size-1
              trn += trn_name.translater_name + ", "
            else
              trn +=  trn_name.translater_name  
            end
          end
          adat.special = true
          adat.save
          render html: (adat.name + "||||Ł" + adat.version + "||||Ł" + game.slug + "||||Ł" + trn  )
      else
      render html: ("")
      end
  end
end
