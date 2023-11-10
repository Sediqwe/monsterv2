class CreateStipis < ActiveRecord::Migration[7.0]
  def change
    create_table :stipis do |t|
      t.text :desc
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.boolean :okes, default: false

      t.timestamps
    end
  end
end
