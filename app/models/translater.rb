class Translater < ApplicationRecord
    has_many :uploads
    validates :translater_name, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
    has_one :user    
end
