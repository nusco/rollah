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
