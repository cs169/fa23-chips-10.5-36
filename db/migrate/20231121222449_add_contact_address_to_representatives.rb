class AddContactAddressToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :contact_address, :string
  end
end
