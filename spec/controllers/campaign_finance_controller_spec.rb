# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'webmock/rspec'

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
      expected_category = { endCash: 'End Cash' }
      expect(assigns(:categories_to_names)).to include(expected_category)
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
