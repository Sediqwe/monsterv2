class SetEmptyAliasToNilInUsers < ActiveRecord::Migration[7.0]
  
  def up
    User.where(alias: '').update_all(alias: nil)
  end
  
end
