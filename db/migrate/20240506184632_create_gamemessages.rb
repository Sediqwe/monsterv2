class CreateGamemessages < ActiveRecord::Migration[7.0]
  def change
    create_table :gamemessages do |t|
      t.text :message
      t.references :user, null: false, foreign_key: true
      t.boolean :accept
      t.references :game, null: false, foreign_key: true
      t.boolean :reply
      t.references :gamemessage, foreign_key: true

      t.timestamps
    end
  end
end
