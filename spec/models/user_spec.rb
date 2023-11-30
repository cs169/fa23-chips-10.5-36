# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_auth_helper'

describe User do
  describe 'methods' do
    before do
      @github_user = ModelAuthHelper.init_github_user
      @google_user = ModelAuthHelper.init_google_user
    end

    it 'calls name' do
      expect(@google_user.name).to eq 'Google Test User'
    end

    it 'calls auth_provider' do
      expect(@github_user.auth_provider).to eq 'Github'
    end

    it 'calls User find_google_user' do
      result = described_class.find_google_user('1')
      expect(result).to eq @google_user
    end

    it 'calls User find_github_user' do
      result = described_class.find_github_user('1')
      expect(result).to eq @github_user
    end

    it 'calls User find_github_user w wrong id' do
      result = described_class.find_github_user('0')
      expect(result).to be_nil
    end
  end
end
