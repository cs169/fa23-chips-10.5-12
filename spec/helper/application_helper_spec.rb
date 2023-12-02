# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#nav_items' do
    it 'returns an array of navigation items' do
      expected_nav_items = [
      { title: 'Representatives', link: '/representatives' },
      { title: 'Campaign Finance', link: '/campaign_finance' }
    ]
      expect(described_class.nav_items).to include(*expected_nav_items)
    end
  end

  describe '#active' do
    it 'returns the appropriate class for active navigation item' do
      curr_controller_name = 'events'
      nav_link = '/events'

      expect(described_class.active(curr_controller_name, nav_link)).to eq('bg-primary-active')
    end
  end
end
