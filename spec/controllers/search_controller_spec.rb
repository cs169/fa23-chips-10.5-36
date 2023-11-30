# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_auth_helper'

describe SearchController do
  describe 'search controller method' do
    before do
      @rep = Representative.create!({ name: 'Test Representative', created_at: '2023-11-19 22:22:00',
updated_at: '2023-11-19 22:23:00', ocdid: 'ocd-division/country:us', title: 'Test Title' })
      @mock_result = double
      @mock_service = double
      allow(@mock_service).to receive(:key=).and_return(Rails.application.credentials[:GOOGLE_API_KEY])
      allow(@mock_service).to receive(:representative_info_by_address).with(
        { address: 'Test Address' }
      ).and_return(@mock_result)
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(@mock_service)
      allow(Representative).to receive(:civic_api_to_representative_params).with(
        @mock_result
      ).and_return([@rep])
      @uid = ModelAuthHelper.init_github_user.id
    end

    it 'calls search' do
      get :search, params: { address: 'Test Address' }, session: { current_user_id: @uid }
      expect(assigns(:representatives)).to eq([@rep])
    end
  end
end
