# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'
require 'model_auth_helper'

describe NewsItemsController do
  describe 'news controller method' do
    before do
      @rep = ModelHelper.create_representative
      @news_item = ModelHelper.create_news(@rep.id)
      @uid = ModelAuthHelper.init_github_user.id
    end

    it 'calls index' do
      get :index, params: { representative_id: @rep.id }, session: { current_user_id: @uid }
      expect(response).to render_template :index
    end

    it 'calls show' do
      get :show, params:  { representative_id: @rep.id, id: @news_item.id },
                 session: { current_user_id: @uid }
      expect(response).to render_template :show
    end
  end
end
