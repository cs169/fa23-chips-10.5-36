# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all


  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      contact_address_temp = '' 
      political_party_temp = '' 
      photo_url_temp = ''
  

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
  
          contact_address_temp = official.address&.first&.line1
          political_party_temp = official.party
          photo_url_temp = official.photo_url
        end
      end

      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp, contact_address: contact_address_temp, political_party: political_party_temp, photo_url: photo_url_temp })
      reps.push(rep)
    end

    reps
  end
end
