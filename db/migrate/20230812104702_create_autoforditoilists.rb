class CreateAutoforditoilists < ActiveRecord::Migration[7.0]
  def change
    create_table :autoforditoilists do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :tipus
      t.boolean :active, default: true
      t.text :gname
      t.timestamps
    end
  end
end
