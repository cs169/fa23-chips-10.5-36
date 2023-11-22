# frozen_string_literal: true

class AddPoliticalPartyToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :political_party, :string
  end
end
