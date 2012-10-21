Given /the following user exist/ do |tb|
  tb.hashes.each do |t|
  	User.create!(t)
  end
end

Given /the following student exist/ do |tb|
  tb.hashes.each do |t|
  	Student.create!(t)
  end
end
