class Gamemessage < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game
  def self.latest_messages_per_game
    # Első lépésként lekérjük az utolsó 10 üzenetet minden game_id-hez,
    # és rendezzük azokat időrendben csökkenő sorrendbe.
    latest_messages = Gamemessage.order(created_at: :desc).limit(10)

    # Majd csoportosítjuk az üzeneteket game_id szerint, és kiválasztjuk a legfrissebb üzenetet minden csoportból.
    latest_messages_per_game = latest_messages.group_by(&:game_id).map { |_, messages| messages.first }

    return latest_messages_per_game
  end
end
