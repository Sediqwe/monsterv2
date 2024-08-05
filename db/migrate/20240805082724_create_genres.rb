class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :name_en
      t.string :name_hu

      t.timestamps
    end
  end
end
