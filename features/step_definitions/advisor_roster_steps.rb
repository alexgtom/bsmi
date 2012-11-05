Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.should match /#{e1}.*?#{e2}/m
end

Given /I am signed in as a student advisor and have students and teachers in system/ do
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
    
    user = User.new({:first_name => 'Andrew',
    :last_name => 'Mains',
    :street_address => 'blah',
    :city => 'Berkeley',
    :state => 'CA',
    :zipcode => '94000',
    :phone_number => '123-456-7890',
    :email => 'andrew@berkeley.edu',
    :password => '1234',
    :password_confirmation => '1234'})
    
    owner = User.build_owner("Student")
    user.owner = owner
    user.save
    owner.save
    
    
    user = User.new({:first_name => 'Orion',
    :last_name => 'Allen',
    :street_address => '346 soda UC Berkeley',
    :city => 'Berkeley',
    :state => 'CA',
    :zipcode => '94000',
    :phone_number => '123-456-7890',
    :email => 'orion@berkeley.edu',
    :password => '1234',
    :password_confirmation => '1234'})
    
    owner = User.build_owner("Student")
    user.owner = owner
    user.save
    owner.save
    
    user = User.new({:first_name => 'Alex',
    :last_name => 'Tom',
    :street_address => '346 soda UC Berkeley',
    :city => 'Berkeley',
    :state => 'CA',
    :zipcode => '94000',
    :phone_number => '123-456-7890',
    :email => 'alex@berkeley.edu',
    :password => '1234',
    :password_confirmation => '1234'})
    
    owner = User.build_owner("MentorTeacher")
    user.owner = owner
    user.save
    owner.save
    
    user = User.new({:first_name => 'Tony',
    :last_name => 'Adam',
    :street_address => '346 soda UC Berkeley',
    :city => 'Berkeley',
    :state => 'CA',
    :zipcode => '94000',
    :phone_number => '123-456-7890',
    :email => 'tony@berkeley.edu',
    :password => '1234',
    :password_confirmation => '1234'})
    
    owner = User.build_owner("MentorTeacher")
    user.owner = owner
    user.save
    owner.save
    
end
