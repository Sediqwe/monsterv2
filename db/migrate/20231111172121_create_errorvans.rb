class CreateErrorvans < ActiveRecord::Migration[7.0]
  def change
    create_table :errorvans do |t|
      t.string :page
      t.string :desc

      t.timestamps
    end
  end
end
