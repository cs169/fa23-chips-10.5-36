# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe AjaxController do
  describe 'rendering county json' do
    before do
      ModelHelper.init_sf
      @expected_response = [{ 'created_at' => '2023-11-19T22:20:00.000Z', 'fips_class' => 'H1', 'fips_code' => 75,
      'id' => 1,
      'name' => '["San Francisco County", "06", 75, "H1", "2023-11-19 22:20:00", "2023-11-19 22:20:00"]',
      'state_id' => 1,
      'updated_at' => '2023-11-19T22:20:00.000Z' }]
    end

    it 'calls counties' do
      get :counties, params: { 'state_symbol' => 'CA' }, format: :json
      actual_response = JSON.parse(response.body)
      expect(actual_response).to eq @expected_response
    end
  end
end
