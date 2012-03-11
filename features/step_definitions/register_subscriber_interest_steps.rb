When /^I send the subscriber form with my email$/ do
  visit root_path
  fill_in "subscriber[email]", :with => "runeroniek@gmail.com"
  click_button "Enviar"
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end
