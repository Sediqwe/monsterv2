class AddDemoToUploads < ActiveRecord::Migration[7.0]
  def change
    add_column :uploads, :demo, :boolean, default: false    
  end
end
