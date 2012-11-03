Given /the following timeslots exist/ do |tb|
  tb.hashes.each do |t|
  	Timeslot.create!(t)
  end
end

Given /the following preferences exist/ do |tb|
  tb.hashes.each do |t|
  	Preference.create!(t)
  end
end

When /^I click element containing "([^\"]+)"$/ do |text|
  matcher = ['*', { :text => text }]
  element = page.find(:css, *matcher)
  while better_match = element.first(:css, *matcher)
    element = better_match
  end
  element.click
end

# Brandon Keepers' "click on any element with given text" Capybara selector/Cucumber
# step pairing, adapted for Capybara 1.0+.
#   http://collectiveidea.com/blog/archives/2010/08/03/clicking-any-element-with-cucumber-and-capybara/
#Capybara.add_selector(:element) do
#  xpath { |locator| "//*[normalize-space(text())=#{XPath::Expression::StringLiteral.new(locator)}]" }
#end
#
#When 'I click "$locator"' do |locator|
#  msg = "No element found with the content of '#{locator}'"
#  find(:element, locator, :message => msg).click
#end

# Or a possible simplified alternative:
#When 'I click "$locator"' do |locator|
#  find(:xpath, XPath::HTML.content(locator)).click
#end
