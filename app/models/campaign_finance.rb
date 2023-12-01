# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'
require 'net/http'
require 'uri'
require 'json'

class CampaignFinance < ApplicationRecord
  def self.top_candidates(category, cycle)
    #raw data to get it display
    @selected_cycle = '2022'
    @selected_category = 'Contribution Total'
    @top_candidates = [
      { name: 'John Doe', party: 'Democratic', contributions: 50000 },
      { name: 'Jane Smith', party: 'Republican', contributions: 45000 },].sort_by { |candidate| candidate[:name] }
  end
end
