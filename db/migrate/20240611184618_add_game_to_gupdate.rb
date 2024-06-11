class AddGameToGupdate < ActiveRecord::Migration[7.0]
  def change
    add_reference :gupdates, :game, null: false, foreign_key: true
  end
end
