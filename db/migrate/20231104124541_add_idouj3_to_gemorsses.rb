class AddIdouj3ToGemorsses < ActiveRecord::Migration[7.0]
  def change
    add_column :gemorsses, :idouj3, :datetime
  end
end
