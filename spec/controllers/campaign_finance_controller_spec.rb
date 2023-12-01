# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'webmock/rspec'

describe CampaignFinanceController do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns cycles and categories' do
      get :index
      expect(assigns(:cycles)).to be_present
      expect(assigns(:categories)).to be_present
    end

    it 'assigns cycles correctly' do
      get :index
      expect(assigns(:cycles)).to eq((PropublicaAdapter::START_CYCLE..PropublicaAdapter::CURRENT_CYCLE).step(2).sort.to_a)
    end

    it 'assigns categories correctly' do
      get :index
      expected_categories = PropublicaAdapter::CATEGORIES.transform_values { |v| v.titleize.gsub("-", " ") }
      expect(assigns(:categories)).to eq(expected_categories)
    end
  end

  describe '#preprocess_categories' do
    it 'transforms categories to human-readable format' do
      controller = CampaignFinanceController.new
      categories = { candidateLoan: 'candidate-loan', contributionTotal: 'contribution-total' }
      processed_categories = controller.send(:preprocess_categories, categories)
      
      expect(processed_categories).to eq({ candidateLoan: 'Candidate Loan', contributionTotal: 'Contribution Total' })
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
