Feature: news items have issues
  As a user
  I want to see what issue a news item is about
  So that I can more easily tell what a representative talks about

@load-db-seed-data
Scenario: User sees Issue column in news item index for Gavin Newsom
  Given I navigate to the representative with id 1s news item page
  Then I should see the word "Issue"

@load-db-seed-data
Scenario: User sees Issue column in news item show page
  Given I navigate to the number 1 news item for representative with id 1
  Then I should see the word "Issue"
