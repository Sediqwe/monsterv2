class Car < ApplicationRecord
  belongs_to :user
  has_many :chartos
  has_many :prochartos
end
