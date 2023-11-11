class AddGamenameToStipis < ActiveRecord::Migration[7.0]
  def change
    add_column :stipis, :gamename, :text
  end
end
