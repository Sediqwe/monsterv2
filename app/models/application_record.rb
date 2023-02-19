class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.default_timezone
    :utc
  end
  def self.ransackable_attributes(auth_object = nil)
    [ "name", "slug"]
end
end
