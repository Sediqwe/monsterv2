class LefoglalvaController < ApplicationController
  def index
    adat = Game.where(stipi: true).where(okes:false).first
    if adat
        adat.okes = true
        adat.save
        name = adat.user.alias || adat.user.name
        render html: (name + "||||Ł" + adat.name + "||||Ł" + adat.slug + "||||Ł" + url_for(adat.image) + "||||Ł" + adat.hatarido.to_s )
    else
    render html: ("")
    end
  end
end
