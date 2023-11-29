class AddReadyToYoutubevideos < ActiveRecord::Migration[7.0]
  def change
    add_column :youtubevideos, :ready, :boolean, default: true
  end
end
