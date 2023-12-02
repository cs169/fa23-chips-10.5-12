# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#nav_items' do
    it 'returns an array of navigation items' do
      expect(ApplicationHelper.nav_items).to eq([
        { title: 'Home', link: '/' },
        { title: 'Events', link: '/events' },
        { title: 'Representatives', link: '/representatives' },
        { title: 'Campaign Finance', link: '/campaign_finance' }
      ])
    end
  end

  describe '#active' do
    it 'returns the appropriate class for active navigation item' do
      curr_controller_name = 'events'
      nav_link = '/events'

      expect(ApplicationHelper.active(curr_controller_name, nav_link)).to eq('bg-primary-active')

      curr_controller_name = 'representatives'
      nav_link = '/events'

      expect(ApplicationHelper.active(curr_controller_name, nav_link)).to eq('')
    end
  end
end