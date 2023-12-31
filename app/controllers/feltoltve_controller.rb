class FeltoltveController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  def index
      
      adat = Upload.where('created_at <= ?', 3.minutes.ago).where(special: [false, nil]).first
      if adat
          game = Game.find(adat.game_id)
          translater = Uploadtranslater.where(upload_id: adat.id)
          trn = ""
          trn_link = ""
          p translater.inspect
          translater.each_with_index do |dorka, index|
            trn_name = Translater.find(dorka.translater_id)
            if index < translater.size-1
              trn += trn_name.translater_name + ", "
              trn_link += "https://gep.monster/translaters/" + trn_name.slug + "\n "
            else
              trn +=  trn_name.translater_name
              trn_link += "https://gep.monster/translaters/" + trn_name.slug  
            end
          end
          adat.special = true
          adat.save
          render html: (adat.name + "||||Ł" + adat.version + "||||Ł" + game.slug + "||||Ł" + trn  + "||||Ł" + url_for(game.image) + "||||Ł" + trn_link )
      else
      render html: ("")
      end
  end
end
