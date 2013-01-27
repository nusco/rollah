Feature: Basic Roll

In order to get my numbers
as a Player
I want to roll dice

Background:
  Given I use weighted dices

Scenario: Roll one dice
  Given I am on the homepage
  When I write "d6" in "Dice:"
  And I press "Roll Now"
  Then I should see "6"
