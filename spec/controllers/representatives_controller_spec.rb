# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe RepresentativesController do
  describe '#index' do
    it 'assigns array of all representatives to @representatives' do
      @representative = Representative.create({ name: 'Kamala Harris', ocdid: '1', title: '' })
      get :index
      expect(assigns(:representatives)).to eq([@representative])
    end
  end

  describe '#show' do
    before :each do
      @representative = Representative.create({ name: 'Kamala Harris', ocdid: '1', title: '' })
      @officials = [double('official1', name: 'Kamala Harris', photo_url: 'url')]
    end
    
    it 'finds and assigns the correct representative to @representative' do
      get :show, params: { id: @representative.id }
      expect(assigns(:representative)).to eq(@representative)
    end

    it 'assigns the details of the representative to @details' do 
      allow(Representative).to receive(:get_representatives_by_ocdid).and_return(@officials)
      get :show, params: { id: @representative.id }
      expect(assigns(:details)).to eq(@officials[0])
    end

    it 'assigns @photoUrlExists to true if a photo_url exists in details of representative' do
      allow(Representative).to receive(:get_representatives_by_ocdid).and_return(@officials)
      get :show, params: { id: @representative.id }
      expect(assigns(:photoUrlExists)).to be_truthy
    end
  end
end
