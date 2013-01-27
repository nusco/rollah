Feature: Basic Roll

In order to get my numbers
as a Player
I want to roll dice

Background:
  Given I use weighted dice

Scenario: Roll one dice
  Given I am on the homepage
  When I write "d6" in "dices"
  And I press "Roll now"
  Then I should see "1"
