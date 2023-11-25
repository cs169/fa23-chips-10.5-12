# frozen_string_literal: true

class Office
  attr_accessor :name, :official_indices, :division_id
end

FactoryBot.define do
  factory :office do
    name { 'King of the Hill' }
    official_indices { [0, 1, 2, 3] }
    division_id { 'ocd-division/country:us/state:ca/county:sacramento' }
  end
end
