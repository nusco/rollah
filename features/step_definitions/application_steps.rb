Given /^I use weighted dices$/ do
  DiceRoller.weight_dices!
end

Given /^I am on the homepage$/ do
  visit "/"
end

When /^I write "(.*?)" in "(.*?)"$/ do |text, textfield|
  fill_in textfield, :with => text
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content text
end
