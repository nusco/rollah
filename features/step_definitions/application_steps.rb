Given /^I use weighted dices$/ do
  Rollah.weight_dice!
end

Given /^it's January 27th, 2013 at noon$/ do
  Timecop.freeze(Time.local(2013, 1, 27, 12, 0, 0))
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

After do
  Timecop.return
end
