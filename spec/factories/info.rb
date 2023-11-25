# frozen_string_literal: true

class Info
  attr_accessor :offices, :officials
end

FactoryBot.define do
  factory :info do
    offices { nil }
    officials { nil }
  end
end
