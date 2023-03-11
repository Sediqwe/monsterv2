class CreateLemurs < ActiveRecord::Migration[7.0]
  def change
    create_table :lemurs do |t|
      t.string :str
      t.references :project, null: false, foreign_key: true
      t.integer :line
      t.timestamps
    end
  end
end
