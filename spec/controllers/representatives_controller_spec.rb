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
end
