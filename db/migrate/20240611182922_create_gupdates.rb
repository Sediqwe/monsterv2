class CreateGupdates < ActiveRecord::Migration[7.0]
  def change
    create_table :gupdates do |t|
      t.string :content
      t.boolean :active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
