class AddContactAddressAndPoliticalPartyToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :contact_address, :string
    add_column :representatives, :political_party, :string
  end
end
