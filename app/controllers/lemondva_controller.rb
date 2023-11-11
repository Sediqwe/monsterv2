class LemondvaController < ApplicationController
  def index    
    lemond = Stipi.where(okes: false).first
    if lemond
        adat = Game.find(lemond.game_id)
        lemond.okes = true
        lemond.save
        name = lemond.user.alias||lemond.user.name
        render html: ( name + "||||Ł" + adat.name + "||||Ł" + adat.slug + "||||Ł" + url_for(adat.image) + "||||Ł" + lemond.desc )
    else
    render html: ("")
    end
  end
end
