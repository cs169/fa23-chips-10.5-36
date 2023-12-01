# frozen_string_literal: true

require 'faraday'
class CampaignFinance < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.cycles
    # any number between 2010 and 2020, inclusive
    (2010..2020).to_a
  end

  def self.categories
    {
      'Candidate Loan'      => 'candidate-loan',
      'Contribution Total'  => 'contribution-total',
      'Debts Owed'          => 'debts-owed',
      'Disbursements Total' => 'disbursements-total',
      'End Cash'            => 'end-cash',
      'Individual Total'    => 'individual-total',
      'PAC Total'           => 'pac-total',
      'Receipts Total'      => 'receipts-total',
      'Refund Total'        => 'refund-total'
    }
  end

  def self.find_top_twenty(cycle_in, category_in)
    cycle = cycle_in
    category = categories[category_in]
    api_key = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
    api_url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"
    response = Faraday.get(api_url) do |req|
      req.headers['X-API-Key'] = api_key
    end
    # process the results so we can use them in the controller
    JSON.parse(response.body)['results']
  end
end
