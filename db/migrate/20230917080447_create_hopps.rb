class CreateHopps < ActiveRecord::Migration[7.0]
  def change
    create_table :hopps do |t|
      t.text :link
      t.string :gen
      t.integer :open, default: 0

      t.timestamps
    end
  end
end
