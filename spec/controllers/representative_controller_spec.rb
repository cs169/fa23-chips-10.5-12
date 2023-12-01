# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:representative) { create(:representative) } 
    it 'returns a successful response' do
      get :show, params: { id: representative.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'assigns the correct variables' do
      get :show, params: { id: representative.id }
      expect(assigns(:representative)).to eq(representative)
    end
  end
end
