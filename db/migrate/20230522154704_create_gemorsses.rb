class CreateGemorsses < ActiveRecord::Migration[7.0]
  def change
    create_table :gemorsses do |t|
      t.text :user
      t.text :desc
      t.date :ido
      t.boolean :okes
      t.text :link

      t.timestamps
    end
  end
end
