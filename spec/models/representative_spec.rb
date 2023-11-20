# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe 'testing civic_api method' do
    before do
      described_class.create!(
        name:  'Test Representative',
        ocdid: 'ocd-division/country:us',
        title: 'Test Title'
      )

      allow(@official_mock).to receive(:name).and_return('Test Representative')
      allow(@office_mock).to receive(:name).and_return('Test Title')
      allow(@office_mock).to receive(:division_id).and_return('ocd-division/country:us')
      allow(@office_mock).to receive(:official_indices).and_return([])

      @rep_info = double
      allow(@rep_info).to receive(:officials).and_return([@official_mock])
      allow(@rep_info).to receive(:offices).and_return([@office_mock])
    end

    it 'calls civic method' do
      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.length).to eq 1
    end
  end
end
