class Translater < ApplicationRecord
    has_many :uploads
    has_many :uploadtranslaters
    validates :translater_name, uniqueness: true, presence: true, length: {minimum: 2, maximum:100}
    has_one :user
    extend FriendlyId
    friendly_id :translater_name, use: :slugged
    def should_generate_new_friendly_id?
        translater_name_changed?
    end
    def generate_and_save_slug
        self.slug = self.translater_name.parameterize
        self.save
    end
end
