# frozen_string_literal: true

require 'faraday'
class CampaignFinance < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.find_top_twenty; end
end
