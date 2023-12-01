# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'

class CampaignFinanceController < ApplicationController
  @cycles = (PropublicaAdapter::START_CYCLE..PropublicaAdapter::CURRENT_CYCLE).step(2).to_a
end
