class Autoforditoilist < ApplicationRecord
  belongs_to :game
  def self.ransackable_attributes(auth_object = nil)
    [ "gname"]
  end

end
