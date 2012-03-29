Given /^I'm on the questions page$/ do
  visit questions_path
end

Given /^there is a question$/ do
  @question = FactoryGirl.create(:question)
end

Given /^there is a truth about ([^"]*)$/ do |arg1|
  @truth = FactoryGirl.create(:question, :role_type => "truth", :category => Category.find_by_name(arg1))
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
    page.execute_script("$(\"select[name='question[category_id]']\").val(#{Category.find_by_name(arg1).id})")
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

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Then /^I should see ([^"]*)$/ do |arg1|
  case arg1
    when "a Facebook share button for this question"
      page.should have_css("li[data-id=\"#{@question.id}\"] a.fb_btn")
    when "a Twitter share button for this question"
      page.should have_css("li[data-id=\"#{@question.id}\"] a.twitter_btn")
    when "some share buttons for my truth"
      page.find(".form.truth").should have_css("a.twitter_btn")
      page.find(".form.truth").should have_css("a.fb_btn")
    when "some share buttons for my dare"
      page.find(".form.dare").should have_css("a.twitter_btn")
      page.find(".form.dare").should have_css("a.fb_btn")
    else
      page.should have_content(arg1)
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
