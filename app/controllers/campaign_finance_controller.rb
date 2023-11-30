# frozen_string_literal: true

require 'lib/api_adapters/propublica_adapter'

class CampaignFinanceController < ApplicationController
  @cycles = (PropublicaAPIAdapter::START_CYCLE..PropublicaAPIAdapter::CURRENT_CYCLE).step(2).to_a
end
