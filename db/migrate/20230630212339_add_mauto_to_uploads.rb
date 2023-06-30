class AddMautoToUploads < ActiveRecord::Migration[7.0]
  def change
    add_column :uploads, :mauto, :boolean, default: false
  end
end
