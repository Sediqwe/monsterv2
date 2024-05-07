class RemoveUniqueConstraintFromGemorssesLinkIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :gemorsses, :link, unique: true
    add_index :gemorsses, :link
  end
end
