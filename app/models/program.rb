class Program < ApplicationRecord
    has_many :uploads
    validates :program_name, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
end
