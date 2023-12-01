# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'webmock/rspec'

describe CampaignFinanceController do
  describe 'class variables' do
    it 'configures cycles correctly' do
      stub_const('PropublicaAdapter::START_CYCLE', 2)
      stub_const('PropublicaAdapter::CURRENT_CYCLE', 10)
      expect(described_class.instance_variable_get(:@cycles)).to eq(
        [1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018]
      )
    end

    describe 'categoriesToNames' do
      it 'properly maps candidateLoan' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:candidateLoan])
          .to eq('Candidate Loan')
      end

      it 'properly maps contributionTotal' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:contributionTotal])
          .to eq('Contribution Total')
      end

      it 'properly maps debtsOwed' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:debtsOwed])
          .to eq('Debts Owed')
      end

      it 'properly maps disbursementsTotal' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:disbursementsTotal])
          .to eq('Disbursements Total')
      end

      it 'properly maps endCash' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:endCash])
          .to eq('End Cash')
      end

      it 'properly maps individualTotal' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:individualTotal])
          .to eq('Individual Total')
      end

      it 'properly maps pacTotal' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:pacTotal])
          .to eq('PAC Total')
      end

      it 'properly maps receiptsTotal' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:receiptsTotal])
          .to eq('Receipts Total')
      end

      it 'properly maps refundTotal' do
        expect(described_class.instance_variable_get(:@categories_to_names)[:refundTotal])
          .to eq('Refund Total')
      end
    end
  end

  describe 'Candidate' do
    describe 'get_top_20_by_cycle_and_category' do
      let(:test_cycle) { 16 }
      let(:test_category) { 'candidateLoan' }
      let(:mock_candidate_adapter_class) { double }
      let(:mock_adapter) { double }

      it 'calls the adapter method with the correct params' do
        stub_const('PropublicaAdapter::Candidate', mock_candidate_adapter_class)
        allow(mock_candidate_adapter_class).to receive(:new).and_return(mock_adapter)
        allow(mock_adapter).to receive(:get_top_20_by_cycle_and_category)
        described_class.get_top_20_candidates_by_cycle_and_category(test_cycle, test_category)
        expect(mock_adapter).to have_received(:get_top_20_by_cycle_and_category).with(test_cycle, test_category)
      end
    end
  end
end
