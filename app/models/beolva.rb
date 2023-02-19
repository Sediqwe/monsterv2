class Beolva < ApplicationRecord
  belongs_to :user
  has_one_attached :csv_file
  has_many :databeolva, dependent: :destroy
  has_many :chartos, dependent: :destroy
  has_many :scanners, dependent: :destroy
end
