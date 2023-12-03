# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe SearchController do
  describe 'GET #search' do
    context 'with a blank address' do
      it 'display alert to enter location' do
        get :search, params: { address: '' }

        expect(flash[:alert]).to eq('Please enter a location.')
        expect(response).to redirect_to(representatives_path)
      end
    end
  end
end
