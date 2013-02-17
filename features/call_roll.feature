Feature: Call Roll

In order to involve the players
as a Game Master
I want to call a roll

Background:
  Given I use weighted dices

Scenario: Call Roll
  Given I am on the homepage
  When I write "d20+3d6+1d4" in "Dice:"
  And I press "Call a Roll"
  And I bookmark the page and send the link to a player
  And the player opens the page
  And he presses "Roll now"
  And I open the bookmarked page
  Then I should see "Total: 42"
