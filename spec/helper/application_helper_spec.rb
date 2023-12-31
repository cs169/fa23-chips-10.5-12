# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe ApplicationHelper do
  describe '#nav_items' do
    it 'returns reps of navigation items' do
      expected_nav_items = { title: 'Representatives', link: '/representatives' }
      expect(described_class.nav_items).to include(expected_nav_items)
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
