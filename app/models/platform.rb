class Platform < ApplicationRecord
    has_many :uploads
    validates :platform_name, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
end
