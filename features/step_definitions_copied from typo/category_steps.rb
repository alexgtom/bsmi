

Given /^I create and save this category:$/ do |table|
  cat = table.hashes[0]
  fill_in("Name", :with => cat[:name])
  fill_in("Keywords", :with => cat[:keywords])
  fill_in("Permalink", :with => cat[:permalink])
  fill_in("Description", :with => cat[:description])

  click_button 'Save'
end
