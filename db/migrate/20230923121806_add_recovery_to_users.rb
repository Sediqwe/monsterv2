class AddRecoveryToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :recovery, :text
  end
end
