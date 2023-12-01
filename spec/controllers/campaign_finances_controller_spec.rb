# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinancesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @campaign_finances and renders the index template' do
      get :index
      expect(assigns(:campaign_finances)).to eq(CampaignFinance.all)
      expect(assigns(:cycles)).to eq(CampaignFinance.cycles)
      expect(assigns(:categories)).to eq(CampaignFinance.categories)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #search' do
    it 'assigns @campaign_finances based on search parameters' do
      allow(CampaignFinance).to receive(:find_top_twenty).and_return([])
      get :search, params: { cycle: '2020', category: 'Contribution Total' }

      expect(assigns(:campaign_finances)).to eq([])
      expect(response).to render_template('campaign_finances/search')
    end
  end
end
