class CreateForums < ActiveRecord::Migration[7.0]
  def change
    drop_table :forums if table_exists?(:forums)
    create_table :forums do |t|
      t.string :title
      t.text :desc
      t.references :user, null: false, foreign_key: true
      t.boolean :online , default: true
      t.boolean :al 
      t.integer :fo_forum

      t.timestamps
    end
  end
end
