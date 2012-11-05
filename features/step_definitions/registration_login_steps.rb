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

# Given /I am logged in as:/ do |table|
#   visit '/login'
#   table.rows_hash.each do |name, value|
#     fill_in(name, :with => value)
#   end
#   click "Login"
# end


def login(email, password)
  visit '/login'
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Login"
  page.should have_content('Login successful')
end 

Then /^(?:|I )should be located at "([^"]*)"$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == page_name
  else
    assert_equal page_name, current_path
  end
end
