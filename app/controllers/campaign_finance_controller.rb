# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'

class CampaignFinanceController < ApplicationController
  @cycles              = (PropublicaAdapter::START_CYCLE..PropublicaAdapter::CURRENT_CYCLE).step(2).to_a
  @categories_to_names = {
    candidateLoan:      'Candidate Loan',
    contributionTotal:  'Contribution Total',
    debtsOwed:          'Debts Owed',
    disbursementsTotal: 'Disbursements Total',
    endCash:            'End Cash',
    individualTotal:    'Individual Total',
    pacTotal:           'PAC Total',
    receiptsTotal:      'Receipts Total',
    refundTotal:        'Refund Total'
  }
  def search
    @candidates = Campaign.search_candidates(params)
  end
end
