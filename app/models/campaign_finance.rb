# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'
require 'net/http'
require 'uri'
require 'json'

class CampaignFinance < ApplicationRecord
  def self.top_candidates(category, cycle)
    @selected_cycle = '2022'
    @selected_category = 'Contribution Total'
    @top_candidates = [
      { name: 'John Doe', party: 'Democratic'},
      { name: 'Jane Smith', party: 'Republican' }]
      .sort_by { |candidate| candidate[:name] }
  end
end
