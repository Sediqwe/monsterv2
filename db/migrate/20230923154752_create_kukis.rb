class CreateKukis < ActiveRecord::Migration[7.0]
  def change
    create_table :kukis do |t|
      t.string :ertek      

      t.timestamps
    end
  end
end
