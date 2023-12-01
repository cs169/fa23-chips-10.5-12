# frozen_string_literal: true

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
end
