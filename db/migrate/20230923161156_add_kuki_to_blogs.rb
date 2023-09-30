class AddKukiToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :kuki, :string
  end
end
