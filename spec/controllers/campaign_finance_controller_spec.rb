# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe CampaignFinanceController do
  describe 'class variables' do
    it 'configures cycles correctly' do
      stub_const('PropublicaAdapter::START_CYCLE', 2)
      stub_const('PropublicaAdapter::CURRENT_CYCLE', 10)
      expect(described_class.instance_variable_get(:@cycles)).to eq(
        [1996, 1998, 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018]
      )
    end
  end
end
