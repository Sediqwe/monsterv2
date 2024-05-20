class AddMuteToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mute, :boolean, default: false
  end
end
