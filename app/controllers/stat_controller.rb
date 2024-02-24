class StatController < ApplicationController
  require 'googlecharts'
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
      @ipad = Download.all.group(:ip_address).where.not(ip_address: nil).order('count_id DESC').limit(10).count('id')    
      uploads = Upload.all
      meretossz = 0
    

      uploads.each do |upload|
      if upload.game_files.attached?
        meretossz += upload.game_files.blob.byte_size
      end
      end
      meretossz = (meretossz.to_f / 1024 / 1024 / 1024)
      @meretossz = meretossz
      @downloads_by_day = Download.select("DATE(created_at) as download_date, upload_id, COUNT(*) as download_count")
                           .group("download_date, upload_id").order("download_date, download_count DESC, upload_id").limit(10)
                             
  end
  def sanyi

  end
  def random_data
    data = Array.new(6) { rand(1..10) }
    render json: { data: data }
  end
  def bot
    stat = params[:stat]
    
    render html: (stat + "||||Ł")

  end
  
end
