# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'
require 'spec_helper'

describe PropublicaAdapter do
  describe 'initialization' do
    it 'configures constants correctly' do
      expect(described_class::API_VERSION).to eq('v1')
      expect(described_class::API_BASE_URL).to eq('https://api.propublica.org/campaign-finance/v1/')
      expect(described_class::START_CYCLE).to eq(1996)
      expect(described_class::CURRENT_CYCLE).to eq(2018)
    end

    it 'sets the start cycle to an even number' do
      expect(described_class::START_CYCLE.even?).to be(true)
    end

    describe 'CATEGORY' do
      it 'properly maps candidateLoan' do
        expect(described_class::CATEGORIES[:candidateLoan]).to eq('candidate-loan')
      end

      it 'properly maps contributionTotal' do
        expect(described_class::CATEGORIES[:contributionTotal]).to eq('contribution-total')
      end

      it 'properly maps debtsOwed' do
        expect(described_class::CATEGORIES[:debtsOwed]).to eq('debts-owed')
      end

      it 'properly maps disbursementsTotal' do
        expect(described_class::CATEGORIES[:disbursementsTotal]).to eq('disbursements-total')
      end

      it 'properly maps endCash' do
        expect(described_class::CATEGORIES[:endCash]).to eq('end-cash')
      end

      it 'properly maps individualTotal' do
        expect(described_class::CATEGORIES[:individualTotal]).to eq('individual-total')
      end

      it 'properly maps pacTotal' do
        expect(described_class::CATEGORIES[:pacTotal]).to eq('pac-total')
      end

      it 'properly maps receiptsTotal' do
        expect(described_class::CATEGORIES[:receiptsTotal]).to eq('receipts-total')
      end

      it 'properly maps refundTotal' do
        expect(described_class::CATEGORIES[:refundTotal]).to eq('refund-total')
      end
    end
  end

  describe 'base functions' do
    describe 'get' do
      let(:adapter) { Class.new { extend PropublicaAdapter } }
      let(:test_uri) { 'https://api.propublica.org/campaign-finance/v1/test.json' }
      let(:test_route) { 'test' }
      let(:test_body) { 'test' }

      it 'makes a request to the correct uri' do
        stub_request(:get, test_uri)
          .with(headers: { 'X-API-Key' => Rails.application.credentials[:PROPUBLICA_API_KEY] })
          .to_return(body: test_body)
        expect(adapter.get(test_route)).to eq(test_body)
      end
    end
  end

  describe 'Candidate' do
    let(:candidate_adapter) { PropublicaAdapter::Candidate }
    let(:test_cycle) { 16 }
    let(:test_category) { 'candidateLoan' }
    let(:test_uri) { 'https://api.propublica.org/campaign-finance/v1/16/candidates/leaders/candidate-loan.json' }
    let(:test_body) { '{"results": true}' }

    describe 'get_top_20_by_cycle_and_category' do
      it 'makes the correct request' do
        stub_request(:get, test_uri).to_return(body: test_body)
        expect(candidate_adapter.new.get_top_20_by_cycle_and_category(test_cycle, test_category))
          .to be(true)
      end
    end
  end
end
