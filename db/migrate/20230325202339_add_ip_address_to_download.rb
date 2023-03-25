class AddIpAddressToDownload < ActiveRecord::Migration[7.0]
  def change
    add_column :downloads, :ip_address, :string
  end
end
