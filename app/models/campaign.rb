# frozen_string_literal: true

require 'faraday'
require 'json'

class Campaign < ApplicationRecord
  # TODO: Need to get filters from search page
  def self.search_candidates(filters)
    api_key = Rails.application.credentials[:PROPUBLICA_API_KEY]
    # TODO: Get the right form of params with get_cycle() and get_categories() to insert into the url
    cycle = Campaign.get_cycle(filters[:cycle])
    category = Campaign.get_categories(filters[:category]) # TODO: Need to be <value>.json
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}"
    response_json = Faraday.get(url, nil, { 'X-API-Key': api_key })
    response = JSON.parse(response_json.body)
    results = response['results']
    candidates = []
    (0...results.length).each do |i|
      name = results[i]['name']
      candidates.append(name)
    end
    candidates
  end
end
