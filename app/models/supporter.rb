class Supporter < ApplicationRecord
    validates :name, presence: true, length: {minimum: 2, maximum:100}
    validates :datum, presence: true, length: {minimum: 2, maximum:100}
    validates :euro, presence: true
end
