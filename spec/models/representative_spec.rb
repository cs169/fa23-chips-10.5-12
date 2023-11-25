# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe 'using civic_api_to_representative_params' do
    before do
      offical = build(:representative, name: 'Joe Diggs')
      offical.save!

      @official = build(:representative, name: 'Micheal McDoesntExist')
      @office = build('office')
      @rep_info = build('info', offices: [@office], officials: [@official])
    end

    it 'makes sure before it is working' do
      expect(described_class.first.name).to eq('Joe Diggs')
    end

    it 'returns a representative if new' do
      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.size).to eq(1)
      expect(result[0].name).to eq('Micheal McDoesntExist')
    end

    it 'does not return a representative if duplicate' do
      official = build(:representative, name: 'Joe Diggs')
      @rep_info.stub(:officials).and_return([official])

      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.size).to eq(0)
    end

    it 'gets correct ocdid and title when official_indices include index' do
      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.size).to eq(1)
      expect(result[0].ocdid).to eq('ocd-division/country:us/state:ca/county:sacramento')
      expect(result[0].title).to eq('King of the Hill')
    end

    it 'gets correct ocdid and title when official_indices does not include index' do
      @office.official_indices = []

      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.size).to eq(1)
      expect(result[0].ocdid).to eq('')
      expect(result[0].title).to eq('')
    end
  end
end
