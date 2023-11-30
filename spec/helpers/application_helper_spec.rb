# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe ApplicationHelper do
  describe 'testing state method' do
    before do
      @california = ModelHelper.init_california
      @test_state = ModelHelper.init_state('TestState', 'TS', 0)
    end

    it 'calls state_ids_by_name' do
      result = described_class.state_ids_by_name
      expect(result).to eq({ 'California' => 1, 'TestState' => 2 })
    end

    it 'calls state_symbols_by_name' do
      result = described_class.state_symbols_by_name
      expect(result).to eq({ 'California' => 'CA', 'TestState' => 'TS' })
    end

    it 'calls nav_items' do
      result = described_class.nav_items
      expect(result).to eq([{ link: '/', title: 'Home' },
                            { link: '/events', title: 'Events' },
                            { link: '/representatives', title: 'Representatives' },
                            { link: '/campaign_finances', title: 'Campaign Finances' }])
    end

    xit 'calls active' do
      # Not yet sure how to implement this
      0
    end
  end
end
