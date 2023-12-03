# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe MyNewsItemsController do
  describe '#news_item_params' do
    before do
      @passed_params = ActionController::Parameters.new(
        news_item: { news:              'Some news',
                     title:             'News Title',
                     description:       'News Description',
                     link:              'https://example.com',
                     representative_id: 1,
                     issue:             'Free Speech' }
      )
    end

    it 'permits specific attributes' do
      controller.params = @passed_params
      permitted_params = controller.send(:news_item_params)
      expect(permitted_params[:news]).to eq('Some news')
      expect(permitted_params[:title]).to eq('News Title')
      expect(permitted_params[:description]).to eq('News Description')
    end

    it 'permits specific attributes part 2' do
      controller.params = @passed_params
      permitted_params = controller.send(:news_item_params)
      expect(permitted_params[:link]).to eq('https://example.com')
      expect(permitted_params[:representative_id]).to eq(1)
      expect(permitted_params[:issue]).to eq('Free Speech')
    end
  end
end
