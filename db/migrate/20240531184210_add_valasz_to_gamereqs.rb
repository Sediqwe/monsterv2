class AddValaszToGamereqs < ActiveRecord::Migration[7.0]
  def change
    add_column :gamereqs, :valasz, :integer
  end
end
