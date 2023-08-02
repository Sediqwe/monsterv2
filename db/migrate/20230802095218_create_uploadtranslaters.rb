class CreateUploadtranslaters < ActiveRecord::Migration[7.0]
  def change
    create_table :uploadtranslaters do |t|
      t.references :upload, null: false, foreign_key: true
      t.references :translater, null: false, foreign_key: true

      t.timestamps
    end
  end
end
