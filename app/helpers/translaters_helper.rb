module TranslatersHelper

    def forditasok(id)
        feltoltesek = Upload.where(translater_id: id).order(id: :DESC).first(10)
    end
end
