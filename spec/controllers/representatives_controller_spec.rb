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
    it 'finds and assigns the correct representative to @representative' do
      @representative = create(:representative, name: 'Joe Diggs')
      get :show, params: { id: @representative.id }
      expect(assigns(:representative)).to eq(@representative)
    end

    it 'assigns photo_url_exists to false' do
      @representative = create(:representative, name: 'Joe Diggs')
      official = create(:representative, name: 'Joe Diggs')
      allow(Representative).to receive(:get_representatives_by_ocdid).and_return([official])
      get :show, params: { id: @representative.id }
      expect(assigns(:photo_url_exists)).to be_falsy
    end
  end
end
