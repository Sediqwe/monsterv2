class Game < ApplicationRecord
    has_many :uploads , dependent: :delete_all
    has_many_attached :game_files , dependent: :delete_all
    has_one_attached :image , dependent: :delete_all
    has_many :autoforditoilist
    extend FriendlyId
    friendly_id :name, use: :slugged
    validates :name, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
    validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp']    
    def should_generate_new_friendly_id?
        name_changed?
    end
    def self.ransackable_attributes(auth_object = nil)
        [ "name", "slug"]
    end
    def self.ransackable_associations(auth_object = nil)
        [ "name", "slug"]
    end
   
    
    
end
