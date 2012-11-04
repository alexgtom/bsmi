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

Given /the following invites exist/ do |tb|
  tb.hashes.each do |t|
  	Invite.create!(t)
  end
end

Given /I am signed up as a student advisor/ do
  user = User.new({:first_name => 'Sangyoon',
                :last_name => 'Park',
                :street_address => '346 soda UC Berkeley',
                :city => 'Berkeley',
                :state => 'CA',
                :zipcode => '94000',
                :phone_number => '123-456-7890',
                :email => 'myemail@nowhere.com',
                :password => '1234',
                :password_confirmation => '1234'})

  owner = User.build_owner("Advisor")
  user.owner = owner
  user.save
  owner.save
end

Given /I am invited and on the signup page/ do
  visit "/signup?owner_type=Student&invite_code=aa10df161da4c011d507dea384aa2d03cbc2e5ba"
end

Then /^(?:|I )should be located at "([^"]*)"$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == page_name
  else
    assert_equal page_name, current_path
  end
end
