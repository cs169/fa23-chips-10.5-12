# frozen_string_literal: true

Given('I navigate to the representative with id {int}s news item page') do |id|
  visit "/representatives/#{id}/news_items/"
end

Given('I navigate to the number {int} news item for representative with id {int}') do |news_id, id|
  visit "/representatives/#{id}/news_items/#{news_id}"
end

Then('I should see the word {string}') do |word|
  expect(page).to have_text(word)
end
