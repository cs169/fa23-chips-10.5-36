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
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      get :google_oauth2
      expect(response).to redirect_to(root_path)
      expect(session[:current_user_id]).not_to be_nil
    end

    it 'calls github' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
      get :github
      expect(response).to redirect_to(root_path)
      expect(session[:current_user_id]).not_to be_nil
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
  end
end
