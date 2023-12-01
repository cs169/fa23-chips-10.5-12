# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'

class CampaignFinanceController < ApplicationController
  def index
    @cycles              = (PropublicaAdapter::START_CYCLE..PropublicaAdapter::CURRENT_CYCLE).step(2).sort.to_a
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
  end

  def search
    @cycle = params[:cycle]
    @category = params[:category]
    @top_candidates = CampaignFinance.top_candidates(@category, @cycle)
  end
end
