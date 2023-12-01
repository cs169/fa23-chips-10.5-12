# frozen_string_literal: true

require 'net/http'
require 'json'

module PropublicaAdapter
  API_VERSION   = 'v1'
  API_BASE_URL  = "https://api.propublica.org/campaign-finance/#{self::API_VERSION}/"
  START_CYCLE   = 1996
  CURRENT_CYCLE = 2018
  CATEGORIES    = {
    candidateLoan:      'candidate-loan',
    contributionTotal:  'contribution-total',
    debtsOwed:          'debts-owed',
    disbursementsTotal: 'disbursements-total',
    endCash:            'end-cash',
    individualTotal:    'individual-total',
    pacTotal:           'pac-total',
    receiptsTotal:      'receipts-total',
    refundTotal:        'refund-total'
  }.freeze

  def get(route)
    uri = URI.parse("#{API_BASE_URL}#{route}.json")
    req = Net::HTTP::Get.new(uri)
    req['X-API-Key'] = Rails.application.credentials[:PROPUBLICA_API_KEY]
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
    res.body
  end

  class Candidate
    include PropublicaAdapter
    def get_top_20_by_cycle_and_category(cycle, category)
      route = "#{cycle}/candidates/leaders/#{CATEGORIES[category.to_sym]}"
      JSON.parse(get(route))['results']
    end
  end
end
