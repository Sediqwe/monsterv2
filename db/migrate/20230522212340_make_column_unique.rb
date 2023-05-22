class MakeColumnUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :gemorsses, :link, unique: true
  end
end
