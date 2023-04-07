class Dataproject < ApplicationRecord
  belongs_to :project
  def self.ransackable_associations(auth_object = nil)
    ["project"]
  end
end
