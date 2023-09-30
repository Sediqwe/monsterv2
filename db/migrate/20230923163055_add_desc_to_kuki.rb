class AddDescToKuki < ActiveRecord::Migration[7.0]
  def change
    add_column :kukis, :desc, :text
  end
end
