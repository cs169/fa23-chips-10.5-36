# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe Event do
  describe 'testing state method' do
    before do
      @sf = ModelHelper.init_sf[1]
      @event = described_class.create!(
        name:        'Test Event',
        description: 'Test Description',
        county:      @sf,
        start_time:  '2023-12-31 00:00:00',
        end_time:    '2024-01-01 00:00:00'
      )
    end

    it 'calls county_names_by_id' do
      result = @event.county_names_by_id
      expect(result).to eq [@sf].map { |c| [c.name, c.id] }.to_h
    end
  end
end
