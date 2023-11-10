class AddStipiToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :stipi, :boolean, default: false
    add_column :games, :hidden, :boolean, default: false
    add_column :games, :hatarido, :datetime
    Game.update(hidden: false)
    Game.update(stipi: false)
  end
end
