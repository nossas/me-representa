Given /^I'm on the questions page$/ do
  visit questions_path
end

Given /^there is a question$/ do
  @question = FactoryGirl.create(:question)
end

Given /^there is a ([^"]*) about ([^"]*)$/ do |arg1, arg2|
  @truth = FactoryGirl.create(:question, :role_type => "truth", :category => Category.find_or_create_by_name(arg2)) if arg1 == "truth"
  @dare = FactoryGirl.create(:question, :role_type => "dare", :category => Category.find_or_create_by_name(arg2)) if arg1 == "dare"
end

Given /^I'm logged in$/ do
  visit "/auth/facebook"
end

Given /^I'm logged in as admin$/ do
  visit "/auth/facebook"
  user = User.find_by_email("nicolas@engage.is")
  user.update_attribute(:admin, true)
end

Given /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

Given /^I choose "([^"]*)" for "([^"]*)"$/ do |arg1, arg2|
  case arg2
  when "Assunto"
    page.execute_script("$(\"select[name='question[category_id]']\").val(#{Category.find_or_create_by_name(arg1).id})")
  else
    select arg1, :from => arg2
  end
end

Given /^there is a truth with (\d+) votes saying ([^"]*)$/ do |arg1, arg2|
  @truth = FactoryGirl.create(:question, :role_type => "truth", :text => arg2)
  arg1.to_i.times { |i| FactoryGirl.create(:vote, :question => @truth) }
end

Given /^there is a truth about "([^"]*)" saying "([^"]*)"$/ do |arg1, arg2|
  @truth = FactoryGirl.create(:question, :role_type => "truth", :text => arg2, :category => Category.find_by_name(arg1))
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
  page.execute_script("$('.questions_list li').trigger('mouseover')") if arg1 == "Votar"
  click_on(arg1)
end

When /^I filter ([^"]*) by "([^"]*)"$/ do |arg1, arg2|
  page.execute_script("$(\"select#category_id_#{arg1 == 'truths' ? 'truth' : 'dare'}\").val(#{Category.find_by_name(arg2).id})")
  page.execute_script("$(\".filter-category\").trigger('change')")
end

When /^I go to the questions page$/ do
  visit questions_path
end

When /^I order truths by votes$/ do
  page.execute_script("$('select#order_by_truth').val('voted_first')")
  page.execute_script("$('.order-category').trigger('change')")
  sleep 2
end

Then /^I should not see ([^"]*)$/ do |arg1|
  case arg1
  when "that truth"
    page.should_not have_content(@truth.text)
  when "that dare"
    page.should_not have_content(@dare.text)
  else
    page.should_not have_content(arg1)
  end
end
Then /^I should see ([^"]*)$/ do |arg1|
  case arg1
    when "a Facebook share button for this question"
      page.should have_css("li[data-id=\"#{@question.id}\"] .share_options li.twitter")
    when "a Twitter share button for this question"
      page.should have_css("li[data-id=\"#{@question.id}\"] .share_options li.facebook")
    when "some share buttons for my truth"
      page.find(".form.truth").should have_css("a.twitter_btn")
      page.find(".form.truth").should have_css("a.fb_btn")
    when "some share buttons for my dare"
      page.find(".form.dare").should have_css("a.twitter_btn")
      page.find(".form.dare").should have_css("a.fb_btn")
    when "that dare"
      page.should have_content(@dare.text)
    when "that truth"
      page.should have_content(@truth.text)
    when "1 voto"
      sleep 1
      page.find("li.#{@question.role_type} span.votes").text.should == "1"
    when "question's text field"
      page.should have_css("textarea[name=\"question[text]\"]")
    when "question's role_type field"
      page.should have_css("select[name=\"question[role_type]\"]")
    when "question's category field"
      page.should have_css("select[name=\"question[category_id]\"]")

    else
      page.should have_content(arg1)
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "([^"]*)" above "([^"]*)"$/ do |arg1, arg2|
  page.html.should match(/#{arg1}(.)+#{arg2}/)
end

Then /^I should not see "(.*?)"$/ do |arg1|
  sleep(2)
  page.should_not have_content(arg1) 
end


Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1) 
end
