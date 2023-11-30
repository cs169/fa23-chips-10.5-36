# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe EventsController do
  describe 'event controller methods' do
    before do
      @sf = ModelHelper.init_sf[1]
      @event_sf = ModelHelper.create_event(@sf, 'Test Event')

      @test_state, @test_county = ModelHelper.init_county('TestState', 'TS', 0, 'TestCounty', 0)
      @event_test_county = ModelHelper.create_event(@test_county, 'Test Event')
    end

    it 'calls index without filter' do
      get :index, params: { 'state' => 'CA', 'county' => '75' }
      expect(response).to render_template :index
      expect(assigns(:events)).to eq([@event_sf, @event_test_county])
    end

    it 'calls index with filter' do
      get :index, params: { 'state' => 'CA', 'county' => '75', 'filter-by' => 'state-only' }
      expect(response).to render_template :index
      expect(assigns(:events)).to eq([@event_sf])
    end

    it 'calls show' do
      get :show, params: { 'id' => '1' }
      expect(response).to render_template :show
      expect(assigns(:event)).to eq(@event_sf)
    end
  end
end
