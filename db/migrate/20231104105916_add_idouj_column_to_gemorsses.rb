class AddIdoujColumnToGemorsses < ActiveRecord::Migration[7.0]
  def change
    add_column :gemorsses, :idouj, :string

  end
end
