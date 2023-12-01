# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  def index
    @campaign_finances = CampaignFinance.all
  end

  def search
    @campaign_finance = CampaignFinance.find(params[:id])
  end
end
