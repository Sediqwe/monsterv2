class AddUniqueIndexToLinkInYoutubevideos < ActiveRecord::Migration[7.0]
  def change
    add_index :youtubevideos, :link, unique: true
  end
end
