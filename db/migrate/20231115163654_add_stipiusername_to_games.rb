class AddStipiusernameToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :stipiusername, :string
  end
end
