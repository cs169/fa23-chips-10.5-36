# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe MapController do
  describe 'map controller method' do
    before do
      @california, @sf = ModelHelper.init_sf
      @test_state, @test_county = ModelHelper.init_county('Test State', 'TS', 1, 'Test County', 1)
      @other_test_state = ModelHelper.init_state('Also Test State', 'OTS', 2)
    end

    it 'calls index' do
      get :index, params: { 'state' => 'CA', 'county' => '75' }
      expect(response).to render_template :index
      expect(assigns(:states)).to eq(State.all)
      expect(assigns(:states_by_fips_code)).to eq({ '01' => @test_state, '06' => @california,
'02' => @other_test_state })
    end

    it 'calls state with valid state' do
      get :state, params: { 'state_symbol' => 'CA' }
      expect(response).to render_template :state
      expect(assigns(:state)).to eq(@california)
      expect(assigns(:county_details)).to eq(@california.counties.index_by(&:std_fips_code))
    end

    it 'calls state with invalid state' do
      get :state, params: { 'state_symbol' => 'INVALID' }
      expect(response).to redirect_to(root_path)
    end

    it 'calls county with valid county' do
      get :county, params: { 'state_symbol' => 'CA', 'std_fips_code' => '75' }
      expect(response).to render_template :county
      expect(assigns(:state)).to eq(@california)
      expect(assigns(:county)).to eq(@sf)
      expect(assigns(:county_details)).to eq(@california.counties.index_by(&:std_fips_code))
    end

    it 'calls county with invalid county' do
      get :county, params: { 'state_symbol' => 'CA', 'std_fips_code' => '-1' }
      expect(response).to redirect_to(root_path)
    end
  end
end
