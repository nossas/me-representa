Given /^I'm on the questions page$/ do
  visit questions_path
end

Given /^there is a question$/ do
  @question = FactoryGirl.create(:question)
end

Given /^I'm logged in$/ do
  visit "/auth/facebook"
end

Given /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

Given /^I choose "([^"]*)" for "([^"]*)"$/ do |arg1, arg2|
  case arg2
  when "Assunto"
    page.execute_script("$(\"#select_truth\").val(#{Category.find_by_name(arg1).id})")
  else
    select arg1, :from => arg2
  end
end

When /^I send the subscriber form with my email$/ do
  visit root_path
  fill_in "subscriber[email]", :with => "runeroniek@gmail.com"
  click_button "Enviar"
end

When /^I click "([^"]*)"$/ do |arg1|
  click_link arg1
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button arg1
end

When /^I go to the questions page$/ do
  visit questions_path
end

When /^I pass over this question$/ do
  page.execute_script("$('li[data-id=#{@question.id}]').trigger('mouseover');")
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Then /^I should see ([^"]*)$/ do |arg1|
  case arg1
    when "a Facebook share button for this question"
      page.find("li[data-id=\"#{@question.id}\"] .fb-send").should be_visible
    when "a Twitter share button for this question"
      page.find("li[data-id=\"#{@question.id}\"] .twitter-share-button").should be_visible
    when "some share buttons for my question"
      page.find("li[data-id=\"#{@question.id}\"] .twitter-share-button").should be_visible
    else
      page.should have_content(arg1)
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
