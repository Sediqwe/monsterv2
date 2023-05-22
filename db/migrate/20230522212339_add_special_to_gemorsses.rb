class AddSpecialToGemorsses < ActiveRecord::Migration[7.0]
  def change
    add_column :gemorsses, :special, :text, unique: true
  end
end
