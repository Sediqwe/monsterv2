class AddNameToHopps < ActiveRecord::Migration[7.0]
  def change
    add_column :hopps, :name, :string    
  end
end
