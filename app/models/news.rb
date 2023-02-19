class News < ApplicationRecord
  belongs_to :user
  has_rich_text :desc
  validates :title, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
  validates :desc, uniqueness: true, presence: true
end
