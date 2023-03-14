class CreateRegexadatoks < ActiveRecord::Migration[7.0]
  def change
    create_table :regexadatoks do |t|
      t.string :indito
      t.string :vege
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
