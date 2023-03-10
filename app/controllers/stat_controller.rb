class StatController < ApplicationController
  
  def index
      Download.default_timezone = :utc
      @users = User.all.count
      @adminok = User.where(admin: [true]).count
      @downloads = Download.all.count 
      @mega = Mega.sum(:szamlalo)
      @game_all = Game.all.count
      @game_uploaded_file = Upload.all.count
      @proba = Download.all.group(:upload_id).order('count_id DESC').limit(10).count('id')      
      @toptiz = Download.where("date(created_at) > ?", 14.days.ago.to_date).group(:upload_id).order('count_id DESC').limit(10).count('id') 
      @toptizhet = Download.where("date(created_at) > ?", 7.days.ago.to_date).group(:upload_id).order('count_id DESC').limit(10).count('id') 
  end
end
