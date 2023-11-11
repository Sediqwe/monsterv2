class LemondvaController < ApplicationController
  def index    
    lemond = Stipi.where(okes: false).first
    if lemond
        lemond.okes = true
        lemond.save
        name = lemond.user.alias||lemond.user.name
        render html: ( name + "||||Ł" + lemond.gamename  + "||||Ł" + lemond.desc )
    else
    render html: ("")
    end
  end
end
