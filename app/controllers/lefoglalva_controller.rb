class LefoglalvaController < ApplicationController
  def index
    adat = Game.where(stipi: true).where(okes:false).first
    if adat
        adat.okes = true
        adat.save        
        username = User.find(adat.stipiusername.to_i)
        username = username.alias || username.name
        render html: (username + "||||Ł" + adat.name + "||||Ł" + adat.slug + "||||Ł" + url_for(adat.image) + "||||Ł" + adat.hatarido.to_s )
    else
    render html: ("")
    end
  end
end
