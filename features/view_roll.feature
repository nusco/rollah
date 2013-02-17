Feature: View Roll

In order to check the numbers
as a Player
I want to open a previous roll

Background:
  Given I use weighted dices

Scenario: View rolled roll
  Given it's January 27th, 2013 at noon
  And I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  And I bookmark the page
  And I open the bookmarked page
  Then I should see "Total: 42"
  And I should see "Rolled on January 27, 2013 at 12:00PM"

Scenario: View hanging roll
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Ask for Roll"
  And I bookmark the page
  And I open the bookmarked page
  Then I should see "Waiting for roll..."
  And I should see "Roll Now"

Scenario: Roll not found
  Given I open roll 1234
  Then I should get a 404
  And I should see "Roll not found."
