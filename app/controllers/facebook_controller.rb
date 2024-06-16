class FacebookController < ApplicationController
  def index
    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week
    
    # Lekérdezés az aktuális hét feltöltéseihez
    @facebook = Upload.where(created_at: start_of_week..end_of_week).order('id DESC').limit(200)
  end
end