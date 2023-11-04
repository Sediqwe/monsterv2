class ChangeIdoColumnTypeToString < ActiveRecord::Migration[6.0]
    change_column :gemorsses, :ido, :string  
end