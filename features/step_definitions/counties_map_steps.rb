# frozen_string_literal: true

Given('I navigate to the {string} state map page') do |state_name|
  visit "/state/#{state_name}"
end

When('I click on the Counties in {string} button') do |state_name|
  click_button("Counties in #{state_name}")
end

Then('I should see a map of counties') do
  within('#actionmap-state-counties-table') do
    expect(page).to have_css('tbody tr', minimum: 1)
  end
end

When('I click on the "View" link for the county with county name {string}') do |county_name|
  county_name = URI.encode_www_form_component(county_name).gsub('+', '%20')
  find("a.btn.btn-primary[href=\"/search/#{county_name}\"]").click
end

Then('I should be taken to the search page for county {string}') do |county_name|
  county_name = URI.encode_www_form_component(county_name).gsub('+', '%20')
  expect(page).to have_current_path("/search/#{county_name}")
end

And('I should see a list of representatives') do
  expect(page).to have_content('Alex Padilla')
end
