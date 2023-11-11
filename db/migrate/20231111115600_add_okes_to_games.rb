class AddOkesToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :okes, :boolean, default: false
  end
end
