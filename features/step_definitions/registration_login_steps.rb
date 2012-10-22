Given /the following user exist/ do |tb|
  tb.hashes.each do |t|
  	User.create!(t)
  end
end
