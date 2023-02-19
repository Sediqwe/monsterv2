module UploadsHelper

    def de_rebase
        upload = Upload.all
        upload.each do |p|
            
            p.name = Game.find(p.game_id).name
            p.save
            
        end
    end
end
