# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  def index
    @campaign_finances = CampaignFinance.all
    @cycles = CampaignFinance.cycles
    @categories = CampaignFinance.categories
  end

  def search
    @campaign_finance = CampaignFinance.find_top_twenty(params[:search])
  end
end
