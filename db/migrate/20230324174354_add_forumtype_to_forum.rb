class AddForumtypeToForum < ActiveRecord::Migration[7.0]
  def change
    add_column :forums, :forumtype, :boolean, default: false
    change_column_default :forums, :active, true
    add_column :forums, :gameid, :integer
  end
end
