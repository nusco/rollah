module ApplicationSteps
  step "I use weighted dices" do
    Roll.weight_dice!
  end

  step "it's January 27th, 2013 at noon" do
    Timecop.freeze(Time.local(2013, 1, 27, 12, 0, 0))
  end

  step "I am on the homepage" do
    visit "/"
  end

  step "I open roll :roll_id" do |roll_id|
    visit "/rolls/#{roll_id}"
  end

  step "I write :text in :text_field" do |text, text_field|
    fill_in text_field, :with => text
  end

  step "I press :button" do |button|
    click_button button
  end

  step "he presses :button" do |button|
    click_button button
  end

  step "I follow :link" do |link|
    click_link link
  end

  step "I should see :text" do |text|
    page.should have_content text
  end

  step "I should get a :status_code" do |status_code|
    page.status_code.should eq(status_code.to_i)
  end

  step "I bookmark the page" do
    @link = page.current_url
  end

  step "I bookmark the page and send the link to a player" do
    @link = page.current_url
  end

  step "I open the bookmarked page" do
    visit @link
  end

  step "the player opens the page" do
    visit @link
  end
end

RSpec.configure {|c| c.include ApplicationSteps }