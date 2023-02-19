class SearchController < ApplicationController
  def kereses
    if params[:keres]
      para = params[:keres]
      data = ""
      jatek = Game.where("lower(name) like ?", "%#{para.downcase}%").order(:name)
      jatek.each do |t|
        data += t.name.gsub("'","") + "#https://gep.monster/games/" + t.slug + "\n"
      end
      render html: (data[0..5800])
    end
  end
  def keresesmagyhu
    if params[:keres]
      para = params[:keres]
      data = ""
      jatek = Magyhu.where("lower(name) like ?", "%#{para.downcase}%").order(:name).limit(20)
      jatek_talalt = Magyhu.where("lower(name) like ?", "%#{para.downcase}%").count
      jatek.each do |t|
        bam = t.name.gsub("'","")
        bam = bam.split("\n")

        data += bam[0].strip + "#" + t.link + "\n"
      end
      if jatek_talalt>20
        data += "Első 20 találat... kérlek szűkítsd a keresést"
      end
      render html: (data)
    end
  end
  def keresestl
    if params[:keres]
      para = params[:keres]
      data = ""
      translater = Translater.where("lower(translater_name) like ?", "#{para.downcase}").first
      
      if translater.present?
        trans_count = Upload.where(translater_id: translater.id).count
        upload = Upload.where(translater_id: translater.id).order(id: :DESC).limit(10)
        data = translater.translater_name + "#" + trans_count.to_s + "#"
        upload.each do |uo|
          data += uo.name.gsub("'","") + "@" + uo.game.slug + "\n"
        end
      end
      if data.length<1
        jatek = Translater.where("lower(translater_name) like ?", "%#{para.downcase}%").order(translater_name: :ASC)
        data = "Nincs ilyen fordító az adatbázisban! Hasonló?@"
        jatek.each do |t|
          data += t.translater_name.gsub("'","") + "\n"
        end
      end
      render html: (data)
    end
  end
end
