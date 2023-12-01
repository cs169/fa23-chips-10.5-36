# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinance, type: :model do
  describe '.cycles' do
    it 'returns an array of years from 2010 to 2020' do
      expect(described_class.cycles).to eq((2010..2020).to_a)
    end
  end

  describe '.categories' do
    let(:expected_categories) do
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

    it 'returns a hash of categories' do
      expect(described_class.categories).to eq(expected_categories)
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
