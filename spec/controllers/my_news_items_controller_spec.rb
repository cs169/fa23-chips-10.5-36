# frozen_string_literal: true

# pronto-ignore: all

require 'rails_helper'
require 'spec_helper'
require 'model_helper'
require 'model_auth_helper'

describe MyNewsItemsController do
  describe 'my news controller method' do
    before do
      @rep = ModelHelper.create_representative
      @news_item = ModelHelper.create_news(@rep.id)
      @uid = ModelAuthHelper.init_google_user.id

      @valid_news_item = { title:             'Test News',
                           description:       'Test description',
                           link:              'test.com',
                           representative_id: @rep.id }
      @invalid_news_item = { title:             'Test News',
                             description:       'Test description',
                             link:              'test.com',
                             representative_id: '-1' }

      @valid_params = { representative_id: @rep.id, id: @news_item.id, news_item: @valid_news_item }
      @invalid_params = { representative_id: @rep.id, id: @news_item.id, news_item: @invalid_news_item }
      @session = { current_user_id: @uid }
    end

    it 'calls create with valid params' do
      post :create,
           params:  @valid_params,
           session: @session
      expect(response).not_to render_template :new
    end

    it 'calls create with invalid params' do
      post :create,
           params:  @invalid_params,
           session: @session
      expect(response).to render_template :new
    end

    it 'calls update with valid params' do
      post :update,
           params:  @valid_params,
           session: @session
      @news_item.reload
      expect(response).to redirect_to(representative_news_item_path(@rep, @news_item))
    end

    it 'calls update with invalid params' do
      post :update,
           params:  @invalid_params,
           session: @session
      expect(response).to render_template :edit
    end
  end
end
