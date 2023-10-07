class Download < ApplicationRecord
    belongs_to :game
    belongs_to :upload  
    belongs_to :uploadtranslater, foreign_key: "upload_id", primary_key: "upload_id" 
end
