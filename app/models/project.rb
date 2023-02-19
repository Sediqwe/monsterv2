class Project < ApplicationRecord
  belongs_to :user
  has_many_attached :files, dependent: :destroy
  has_many :dataproject , dependent: :delete_all
end
