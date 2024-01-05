class AddDiscordToYoutubevideo < ActiveRecord::Migration[7.0]
  def change
    add_column :youtubevideos, :discord, :boolean, default: false
  end
end
