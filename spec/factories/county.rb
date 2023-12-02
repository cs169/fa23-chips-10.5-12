# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { 'Alameda' }
    fips_code { 1 }
    fips_class { 'H1' }
    state
  end
end
