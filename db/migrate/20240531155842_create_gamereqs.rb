class CreateGamereqs < ActiveRecord::Migration[7.0]
  def change
    create_table :gamereqs do |t|
      t.text :gamename
      t.text :gamelink
      t.references :user, null: true, foreign_key: true
      t.text :username
      t.references :game, null: true, foreign_key: true
      t.text :desc
      t.boolean :oke, default: false

      t.timestamps
    end
  end
end
