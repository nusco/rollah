Given /^I use weighted dices$/ do
  Rollah.weight_dices!
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

When /^I follow "(.*?)"$/ do |link|
  click_link link
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content text
end

When /^I bookmark the page$/ do
  @bookmark = page.current_url
end

When /^I open the bookmarked page$/ do
  visit @bookmark
end