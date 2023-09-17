class Hopp < ApplicationRecord
    validates :link, uniqueness: true, presence: true, length: {minimum: 10}
end
