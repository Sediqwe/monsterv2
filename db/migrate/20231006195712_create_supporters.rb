class CreateSupporters < ActiveRecord::Migration[7.0]
  def change
    create_table :supporters do |t|
      t.string :name
      t.string :datum
      t.integer :euro

      t.timestamps
    end
  end
end
