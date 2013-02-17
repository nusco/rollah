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

Scenario: Sloppy roll
  Given I am on the homepage
  When I write " D20 +3d6+ d4" in "Dice:"
  And I press "Roll Now"
  Then I should see "Total: 42"
  
Scenario: Roll and go back
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Roll Now"
  And I follow "Roll Another One!"
  Then I should see "Dice:"

Scenario: Wrong roll
  Given I am on the homepage
  When I write "2d" in "Dice:"
  And I press "Roll Now"
  Then I should get a 400
  And I should see "I cannot understand your roll ("2d"?)."
  And I should see "Try to use standard RPG dice conventions - something like "3d6+d4"."
