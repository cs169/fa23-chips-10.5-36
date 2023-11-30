# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_auth_helper'

describe LoginController do
  describe 'login controller method' do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = ModelAuthHelper.mock_google_auth
      OmniAuth.config.mock_auth[:github] = ModelAuthHelper.mock_github_auth
      @uid = ModelAuthHelper.init_github_user.id
    end

    it 'calls google_oauth2' do
      mock_omniauth(:google_oauth2)
    end

    it 'calls github' do
      mock_omniauth(:github)
    end

    it 'calls with logged in' do
      get :login, session: { current_user_id: @uid }
      expect(flash[:notice]).to eq('You are already logged in. Logout to switch accounts.')
      expect(response).to redirect_to(user_profile_path)
    end

    it 'calls logout' do
      get :logout
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You have successfully logged out.')
      expect(session[:current_user_id]).to be_nil
    end

    private

    def mock_omniauth(provider)
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider]
      get provider
      expect(response).to redirect_to(root_path)
      expect(session[:current_user_id]).not_to be_nil
    end
  end
end
