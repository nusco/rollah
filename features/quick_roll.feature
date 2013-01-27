Feature: Quick Roll

In order to get my numbers
as a Player
I want to roll dice

Background:
  Given I use weighted dices

Scenario: Roll dice
  Given it's January 27th, 2013 at noon
  And I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  Then I should see "d20: 20"
  And I should see "d6: 6"
  And I should see "Total: 42"
  And I should see "Rolled on January 27, 2013 at 12:00PM"
  
Scenario: Roll and go back
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  And I follow "Roll Another One!"
  Then I should see "Dice:"
