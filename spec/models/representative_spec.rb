# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'Ash Ketchum')],
        offices:   [OpenStruct.new(name: 'Governor', official_indices: [0], division_id: 'Pallet_Town')]
      )
    end

    it "will create a new representative if they don't exist" do
      described_class.create(name: 'Misty Waterflower', title: 'Governor')
      expect { described_class.civic_api_to_representative_params(rep_info) }.to change(described_class, :count).by(1)
    end

    it "won't create a new representative if they already exist" do
      described_class.create(name: 'Ash Ketchum', title: 'Governor')
      expect { described_class.civic_api_to_representative_params(rep_info) }.not_to change(described_class, :count)
    end
  end
end
