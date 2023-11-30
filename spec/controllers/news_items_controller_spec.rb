# frozen_string_literal: true

# spec/controllers/news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) { Representative.create(name: 'John Doe', title: 'Governor', political_party: 'Independent') }
  let(:news_item) do
    NewsItem.create(title: 'News Article', description: 'Description', link: 'http://example.com',
                    representative: representative)
  end

  describe 'GET #index' do
    it 'assigns @news_items and renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @news_item and renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
      expect(response).to render_template(:show)
    end
  end
end
