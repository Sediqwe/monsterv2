class AddUploadedatToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :uploaded_at, :timestamp
  end
end
