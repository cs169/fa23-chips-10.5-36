# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinance, type: :model do
  describe '.cycles' do
    it 'returns an array of years from 2010 to 2020' do
      expect(described_class.cycles).to eq((2010..2020).to_a)
    end
  end

  describe '.categories' do
    expected_keys = ['Candidate Loan', 'Contribution Total', 'Debts Owed',
                     'Disbursements Total', 'End Cash', 'Individual Total',
                     'PAC Total', 'Receipts Total', 'Refund Total']

    it 'returns the correct categories hash' do
      expect(described_class.categories.keys).to contain_exactly(*expected_keys)
    end
  end

  describe '.find_top_twenty' do
    it 'fetches top twenty campaign finances for a given cycle and category' do
      stub_request(:get, 'https://api.propublica.org/campaign-finance/v1/2020/candidates/leaders/contribution-total.json')
        .to_return(body: { results: [{ name: 'Sample Campaign' }] }.to_json)
      result = described_class.find_top_twenty('2020', 'Contribution Total')
      expect(result).to be_an(Array)
      expect(result).to eq([{ 'name' => 'Sample Campaign' }])
    end
  end
end
