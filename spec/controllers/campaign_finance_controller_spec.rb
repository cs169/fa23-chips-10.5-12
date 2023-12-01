# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe CampaignFinanceController do
  describe 'Campaign search page setup' do
    it 'configures cycles correctly' do
      get :index
      expect(assigns(:cycles)).to eq([1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns the categories_to_names variables' do
      get :index
      expect(assigns(:categories_to_names)).to eq(
        candidateLoan:      'Candidate Loan',
        contributionTotal:  'Contribution Total',
        debtsOwed:          'Debts Owed',
        disbursementsTotal: 'Disbursements Total',
        endCash:            'End Cash',
        individualTotal:    'Individual Total',
        pacTotal:           'PAC Total',
        receiptsTotal:      'Receipts Total',
        refundTotal:        'Refund Total'
      )
    end


  end
end