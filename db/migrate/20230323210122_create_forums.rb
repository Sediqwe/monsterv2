class CreateForums < ActiveRecord::Migration[7.0]
  def change
    create_table :forums do |t|
      t.string :title
      t.text :desc
      t.references :user, null: false, foreign_key: true
      t.boolean :active
      t.boolean :olvashato
      t.timestamps
    end
  end
end
