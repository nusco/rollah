Feature: Basic Roll

In order to get my numbers
as a Player
I want to roll dice

Background:
  Given I use weighted dices

Scenario: Roll dice
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  Then I should see "Total: 42"

Scenario: Roll and go back
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  And I follow "Roll Another One!"
  Then I should see "Dice:"

Scenario: Reopen roll
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  And I bookmark the page
  And I open the bookmarked page
  Then I should see "Total: 42"
