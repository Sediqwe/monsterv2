class AddAzonToGamemessages < ActiveRecord::Migration[7.0]
  def change
    add_column :gamemessages, :azon, :string
    add_index :gamemessages, :azon, unique: true
  end
end
