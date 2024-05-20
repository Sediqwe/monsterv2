class AddActiveToTranslaters < ActiveRecord::Migration[7.0]
  def change
    add_column :translaters, :active, :boolean, default:false
  end
end
