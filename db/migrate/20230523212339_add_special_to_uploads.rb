class AddSpecialToUploads < ActiveRecord::Migration[7.0]
  def change
    add_column :uploads, :special, :boolean, default: false
    Upload.update_all(special: true)
  end
end
