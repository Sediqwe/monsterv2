class RemoveUserIdAndAddUsernameToGamemessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :gamemessages, :user_id, :integer

    add_reference :gamemessages, :user, null: true
    add_column :gamemessages, :username, :string
  end
end
