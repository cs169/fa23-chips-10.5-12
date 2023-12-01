# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'
require 'net/http'
require 'uri'
require 'json'

class CampaignFinance < ApplicationRecord
  def self.top_candidates(category, cycle)
    @selected_cycle = cycle
    @selected_category = category
    @top_candidates = [
      { name: 'John Doe', party: 'Democratic' },
      { name: 'Jane Smith', party: 'Republican' }
    ]
  end
end
