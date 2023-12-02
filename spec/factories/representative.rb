# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :representative do
    name { Faker::Name.name }
    ocdid { 'ocd-division/country:us/state:ca/county:alameda' }
    title { 'Mayor of Value Town' }
    party { 'Democrat' }
    address { '123 Main St' }
    city { 'Oakland' }
    state { 'CA' }
    zip { '94612' }
    photo_url { 'https://test.com/test.jpg' }
  end
end
