class Uploadtranslater < ApplicationRecord
  belongs_to :upload
  belongs_to :translater
  has_many :uploads
end
