class AddUserToYoutubevideos < ActiveRecord::Migration[7.0]
  def change
    add_reference :youtubevideos, :user, null: false, foreign_key: true, default:1
  end
end
