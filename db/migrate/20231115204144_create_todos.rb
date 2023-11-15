class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.text :desc
      t.references :user, null: false, foreign_key: true
      t.integer :prio
      t.boolean :kesz

      t.timestamps
    end
  end
end
