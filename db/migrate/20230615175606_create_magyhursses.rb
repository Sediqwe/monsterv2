class CreateMagyhursses < ActiveRecord::Migration[7.0]
  def change
    create_table :magyhursses do |t|
      t.text :name
      t.text :link
      t.boolean :okes
      t.date :ido
      t.text :desc
      t.text :uploader
      t.text :meret

      t.timestamps
    end
  end
end
