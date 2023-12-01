# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'
require 'model_auth_helper'

describe MyEventsController do
  describe 'my events controller method' do
    before do
      @sf = ModelHelper.init_sf[1]
      @test_county = ModelHelper.init_county('Test State', 'TS', 0, 'Test County', 0)[1]

      @event_sf = ModelHelper.create_event(@sf, 'Test Event')

      @event_test_county = ModelHelper.create_event(@test_county, 'Other Test Event')
      @uid = ModelAuthHelper.init_google_user.id

      @event_data = { name:        'Test Event Name',
                      description: 'Test Event Description',
                      county_id:   @sf.id,
                      start_time:  '2024-11-19 22:20:00',
                      end_time:    '2024-12-19 22:20:00' }
    end

    it 'calls create with no params' do
      post :create, params: { event: { name: 'Test Event Name' } }, session: { current_user_id: @uid }
      expect(response).to render_template :new
    end

    it 'calls create with params' do
      post :create, params: { event: @event_data }, session: { current_user_id: @uid }
      expect(response).to redirect_to(events_path)
    end
  end
end
