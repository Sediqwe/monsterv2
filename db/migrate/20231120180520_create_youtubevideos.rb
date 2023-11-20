class CreateYoutubevideos < ActiveRecord::Migration[7.0]
  def change
    create_table :youtubevideos do |t|
      t.string :link
      t.text :desc
      t.boolean :okes
      t.references :game      

      t.timestamps
    end
  end
end
