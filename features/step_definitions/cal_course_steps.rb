Given /^(?:|I )am in the CalCourse (\w+) (?:(\d+) )page$/ do |page_name, number|
  root_page =  '/cal_courses/'+ number.to_s  + "/" 
  case page_name
    when /^show/
      visit root_page
    when /^edit/
      visit root_page + page_name
  end
end

Given /^(?:|I )am in the CalCourse (\w+) page$/ do |page_name|
  case page_name
    when /^index$/
      visit '/cal_courses'
    when /^new$/
      visit '/cal_courses/new'
    when /^edit$/
      visit '/cal_courses/2/edit'
  end
end


Given /the following cal course exist/ do |tb|
  tb.hashes.each do |t|
    CalCourse.create!(t)
  end
end

