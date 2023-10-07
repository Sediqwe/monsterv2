class Uploadtranslater < ApplicationRecord
  belongs_to :upload
  belongs_to :translater
  has_many :downloads, foreign_key: "upload_id", primary_key: "upload_id"
  has_many :uploads
end
