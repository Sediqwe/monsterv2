class GamerssController < ApplicationController
  def index
    @games = Gemorss.order(idouj3: :DESC).first(10)
    respond_to do |format|
      format.rss { render layout: false } # Ez a feedjira gemnek szól
    end
  end
end
