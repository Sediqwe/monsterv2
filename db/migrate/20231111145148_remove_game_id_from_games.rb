class RemoveGameIdFromGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :stipis, :game_id
  end
end
