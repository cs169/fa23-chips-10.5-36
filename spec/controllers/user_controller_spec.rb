# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_auth_helper'

describe UserController do
  describe 'user controller method' do
    it 'calls profile' do
      @uid = ModelAuthHelper.init_github_user.id
      get :profile, session: { current_user_id: @uid }
      expect(response).to render_template :profile
    end
  end
end
