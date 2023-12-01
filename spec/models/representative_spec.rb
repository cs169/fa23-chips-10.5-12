# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'webmock/rspec'

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
      expect(described_class.all.first.name).to eq('Joe Diggs')
    end

    it 'returns a representative if new' do
      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.size).to eq(1)
      expect(result[0].name).to eq('Micheal McDoesntExist')
    end

    it 'returns a representative if duplicate' do
      official = build(:representative, name: 'Joe Diggs')
      @rep_info.stub(:officials).and_return([official])
      result = described_class.civic_api_to_representative_params(@rep_info)
      expect(result.size).to eq(1)
      expect(result[0].name).to eq('Joe Diggs')
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

    it 'save new reps to database' do
      described_class.civic_api_to_representative_params(@rep_info)
      exists = described_class.exists?(name: 'Micheal McDoesntExist')
      expect(exists).to be_truthy
    end

    it 'does not save duplicate reps to database' do
      official = build(:representative, name: 'Joe Diggs')
      @rep_info.stub(:officials).and_return([official])

      described_class.civic_api_to_representative_params(@rep_info)
      num_joes = described_class.where(name: 'Joe Diggs').count
      expect(num_joes).to eq(1)
    end
  end

  describe 'get_representatives_by_ocdid' do
    let(:test_ocdid) { 'test' }
    let(:mock_service) { double }
    let(:mock_response) { double }

    before do
      allow(described_class).to receive(:civic_info_service).and_return(mock_service)
      allow(mock_service).to receive(:key=)
      allow(mock_service).to receive(:representative_info_by_division).with(test_ocdid).and_return(mock_response)
    end

    it 'makes the proper request' do
      allow(mock_response).to receive(:officials)
      described_class.get_representatives_by_ocdid(test_ocdid)
      expect(mock_service).to have_received(:key=).with(Rails.application.credentials[:GOOGLE_API_KEY])
    end

    it 'returns an empty array on failed request' do
      allow(mock_service).to receive(:representative_info_by_division).with(test_ocdid)
                                                                      .and_raise(Google::Apis::ClientError.new('test'))
      expect(described_class.get_representatives_by_ocdid(test_ocdid)).to eq([])
    end
  end

  describe 'civic_info_service' do
    it 'returns an instance of the CivicInfoService class' do
      expect(described_class.civic_info_service).to be_a(Google::Apis::CivicinfoV2::CivicInfoService)
    end
  end
end
