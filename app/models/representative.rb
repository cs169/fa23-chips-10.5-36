# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.map.with_index do |official, index|
      office = rep_info.offices.find { |o| o.official_indices.include? index }
      next unless office

      Representative.create!({
                               name:            official.name,
                               ocdid:           office.division_id,
                               title:           office.name,
                               contact_address: official.address&.first&.line1,
                               political_party: official.party,
                               photo_url:       official.photo_url
                             })
    end.compact
  end
end
