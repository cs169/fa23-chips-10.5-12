# frozen_string_literal: true

require 'rails_helper'
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
  end
end
