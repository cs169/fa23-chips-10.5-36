# frozen_string_literal: true

require 'rails_helper'
require 'model_helper'

RSpec.describe RepresentativesController, type: :controller do
  before do
    @rep = ModelHelper.create_representative
  end

  describe 'GET #index' do
    it 'assigns @representatives and renders the index template' do
      get :index
      expect(assigns(:representatives)).to eq([@rep])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @representative and renders the show template' do
      get :show, params: { id: @rep.id }
      expect(assigns(:representative)).to eq(@rep)
      expect(response).to render_template(:show)
    end
  end
end
