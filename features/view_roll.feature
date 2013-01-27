Feature: View Roll

In order to check the numbers
as a Player
I want to open a previous roll

Background:
  Given I use weighted dices

Scenario: View roll
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  And I bookmark the page
  And I open the bookmarked page
  Then I should see "Total: 42"

Scenario: Roll not found
  Given I open roll 1234
  Then I should get a 404
  And I should see "Roll not found."
