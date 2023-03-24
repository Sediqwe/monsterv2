class AddForumpointToForum < ActiveRecord::Migration[7.0]
  def change
    add_column :forums, :forumpoint, :integer
  end
end
