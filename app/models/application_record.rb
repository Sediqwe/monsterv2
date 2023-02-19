class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.default_timezone
    :utc
  end
end
