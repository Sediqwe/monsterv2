class FacebookController < ApplicationController
  def index
    start_of_week = Date.current.beginning_of_week
    end_of_week = Date.current.end_of_week.end_of_day
    
    # Lekérdezés az aktuális hét feltöltéseihez
    @facebook = Upload.where(created_at: start_of_week..end_of_week).order('id DESC').limit(200)
  end
end