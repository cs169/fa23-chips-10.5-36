# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.map.with_index do |official, index|
      office = rep_info.offices.find { |o| o.official_indices.include? index }
      next unless office

      Representative.find_or_create_by!(name: official.name, title: office.name) do |rep|
        rep.ocdid = office.division_id
        rep.contact_address = official.address&.first&.line1
        rep.political_party = official.party
        rep.photo_url = official.photo_url
      end
    end.compact
  end
end
