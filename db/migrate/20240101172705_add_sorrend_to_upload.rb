class AddSorrendToUpload < ActiveRecord::Migration[7.0]
  def change
    add_column :uploads, :sorrend, :integer, default: 0
  end
end
