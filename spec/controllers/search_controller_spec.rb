# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe SearchController do
  describe 'GET #search' do
    context 'with a blank address' do
      it 'sets a flash alert and redirects to representatives_path' do
        get :search, params: { address: '' }

        expect(flash[:alert]).to eq('Please enter a location.')
        expect(response).to redirect_to(representatives_path)
      end
    end

    context 'with an invalid location' do
      let(:invalid_location) { 'InvalidLocation' }
    
      it 'sets a flash notice and redirects to representatives_path' do
        allow_any_instance_of(Google::Apis::CivicinfoV2::CivicInfoService)
          .to receive(:representative_info_by_address)
          .with(address: invalid_location)
          .and_return(double('result', officials: []))
    
        get :search, params: { address: invalid_location }
    
        expect(flash[:notice]).to eq('No representative information found.')
        expect(response).to redirect_to(representatives_path)
      end
    end
  end
end
