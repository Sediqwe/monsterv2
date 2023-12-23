class User < ApplicationRecord
    has_secure_password
    before_save { self.name = name.downcase }
    validates :email, uniqueness: true, presence: true, length: {minimum: 5, maximum:100}
    validates :name, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
    has_many :game
    belongs_to :translater
    has_one_attached :photo , dependent: :delete_all
end
