module TranslatersHelper

    def forditasok(id)
        feltoltesek = Upload.where(translater_id: id).order(id: :DESC).first(10)
    end
    def transtop(id)
        translater_id = id
        ingwer = ""
        intem = 1
        top_downloads = Download.group(:upload_id).count.sort_by { |_, count| -count }
        top_downloads.each do |upload_id, count|
            upload = Upload.find(upload_id)            
          if Uploadtranslater.exists?(upload_id: upload_id, translater_id: translater_id)
            ingwer += " <a href=\"/games/#{upload.game.slug}\" class=\"btn bg-dark bg-gradient text-light\" style=\"text-decoration: none; color: #333;\"> #{intem}. #{upload.game.name} (#{count}) »</a> <br>"
            intem += 1
            break if intem > 10  # Kilépés a ciklusból, ha intem értéke 10
          end
        end
        ingwer
      end

end
