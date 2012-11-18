require 'spec_helper'

describe User do

  it "should return first_name if last_name is nil" do
    user = User.create!({:first_name => 'firstname', :last_name => nil, :street_address => 'myaddress', :city => 'mycity', :state => 'CA', :zipcode => '90000', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456', :owner_type => 'Student'})
    user.name.should eq('firstname')
  end

  it "should return ' ' if first_name is nil" do
    user = User.create!({:first_name => nil, :last_name => 'mylastname', :street_address => 'myaddress', :city => 'mycity', :state => 'CA', :zipcode => '90000', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456', :owner_type => 'Student'})
    user.name.should eq(' ')
  end
end
