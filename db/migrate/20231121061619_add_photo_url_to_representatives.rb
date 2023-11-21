# frozen_string_literal: true

class AddPhotoUrlToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :photo_url, :string
  end
end
