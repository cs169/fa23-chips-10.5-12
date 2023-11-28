Feature: county linked to representatives
  As a user
  I want to select a county on the map
  So that I can see a list of representatives of the county

@load-db-seed-data
Scenario: User selects Alameda County to view its representatives
  Given I navigate to the "CA" state map page
  When I click on the Counties in "California" button
  Then I should see a map of counties
  When I click on the "View" link for the county with county name "Alameda County"
  Then I should be taken to the search page for county "Alameda County"
  Then I should see a list of representatives
