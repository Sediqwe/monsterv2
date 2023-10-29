class AddSlugToTranslaters < ActiveRecord::Migration[7.0]
  def change
    add_column :translaters, :slug, :string
    add_index :translaters, :slug, unique: true
  end
end
