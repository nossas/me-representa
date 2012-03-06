Given /^I'm in the root petition page$/ do
  visit root_path
end

Then /^I should see the "([^"]*)" field$/ do |arg1|
  page.has_xpath?("//form/input[@name=\"user[#{arg1}]\"]")
end

When /^I fill the form with my information$/ do
 fill_in "user[email]", :with => "runeroniek@gmail.com"
end

When /^I send the form$/ do
  click_button "Enviar"
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end
