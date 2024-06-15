class UpdateStipiusernameForGames < ActiveRecord::Migration[7.0]
  def up
    Game.where(stipi: false).update_all(stipiusername: "")
  end
end
