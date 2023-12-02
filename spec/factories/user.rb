# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    provider { 1 }
    uid { '123456' }
    email { 'johndoe@gmail.com' }
  end
end
