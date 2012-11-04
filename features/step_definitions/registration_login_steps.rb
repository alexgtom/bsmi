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

Given /the a user of type (\w+) , password (\w+) , name (\w+) , email (\w+) exist/ do |type, pass, name, email|
  user = User.new({:name => name,
                :address => '346 soda UC Berkeley, United States',
                :phone_number => '123-456-7890',
                :email => email,
                :password => pass,
                :password_confirmation => pass})
  owner = User.build_owner(type)
  user.owner = owner
  user.save
  owner.save
end

Given /the mentor teachers from the table exists/ do |tb|
  tb.hashes.each do |t|
    user = User.create!({:name => t["name"],
                :owner_type => "MentorTeacher",
                :address => '346 soda UC Berkeley, United States',
                :phone_number => '123-456-7890',
                :email => t["email"],
                :password => t["password"],
                :password_confirmation => t["password"]})
    MentorTeacher.create!(:user=>user, :school => t["school"])
  end
end

Given /the following users exists/ do |tb|
  tb.hashes.each do |t|
    user = User.new({:name => t[:name],
                :address => '346 soda UC Berkeley, United States',
                :phone_number => '123-456-7890',
                :email => t[:email],
                :password => t[:pass],
                :password_confirmation => t[:pass]})
    owner = User.build_owner(t[:type])
    user.owner = owner
    user.save
    owner.save
  end
end

Given /I am signed up/ do
  user = User.new({:name => 'Sangyoon Park',
                :address => '346 soda UC Berkeley, United States',
                :phone_number => '123-456-7890',
                :email => 'myemail@nowhere.com',
                :password => '1234',
                :password_confirmation => '1234'})

  owner = User.build_owner("MentorTeacher")
  user.owner = owner
  user.save
  owner.save
end

Then /^(?:|I )should be located at "([^"]*)"$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == page_name
  else
    assert_equal page_name, current_path
  end
end
