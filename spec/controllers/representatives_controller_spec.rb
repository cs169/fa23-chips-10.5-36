# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @representatives and renders the index template' do
      representative = Representative.create!(name: 'John Doe', title: 'Governor', political_party: 'Independent')
      get :index
      expect(assigns(:representatives)).to eq([representative])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @representative and renders the show template' do
      representative = Representative.create!(name: 'Jane Smith', title: 'Senator', political_party: 'Independent')
      get :show, params: { id: representative.id }
      expect(assigns(:representative)).to eq(representative)
      expect(response).to render_template(:show)
    end
  end
end
