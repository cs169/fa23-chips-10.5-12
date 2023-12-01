# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'

class CampaignFinanceController < ApplicationController
<<<<<<< HEAD
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
=======
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

  def self.get_top_20_candidates_by_cycle_and_category(cycle, category)
    candidate_adapter = PropublicaAdapter::Candidate.new
    candidate_adapter.get_top_20_by_cycle_and_category(cycle, category)
>>>>>>> cfa6fbd45c077c08bfb0fa35f9b891f1f1a21c8e
  end
end
