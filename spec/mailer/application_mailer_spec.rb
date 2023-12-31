# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe ApplicationMailer do
  describe 'default settings' do
    it 'uses the correct default "from" address' do
      expect(described_class.default[:from]).to eq('from@example.com')
    end
  end
end
