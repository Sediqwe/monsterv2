class Download < ApplicationRecord
    belongs_to :game
    belongs_to :upload  
    belongs_to :uploadtranslater  
end
