class CreateSupportlists < ActiveRecord::Migration[7.0]
  def change
    create_table :supportlists do |t|
      t.string :link
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :active, default: true
      t.string :iconbootstrap

      t.timestamps
    end
  end
end
