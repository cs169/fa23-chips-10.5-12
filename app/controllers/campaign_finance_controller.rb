# frozen_string_literal: true

class CampaignFinanceController < ApplicationController
  def index
    @candidates = Campaign.search_candidates(params)
  end
end
