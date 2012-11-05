require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :first_name => "MyString",
      :last_name => "MyString",
      :street_address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zipcode => "MyString",
      :phone_number => "MyString",
      :email => "MyString",
      :crypted_password => "MyString",
      :persistence_token => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_street_address", :name => "user[street_address]"
      assert_select "input#user_city", :name => "user[city]"
      assert_select "input#user_state", :name => "user[state]"
      assert_select "input#user_zipcode", :name => "user[zipcode]"
      assert_select "input#user_phone_number", :name => "user[phone_number]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_password", :name => "user[password]"
      assert_select "input#user_password_confirmation", :name => "user[password_confirmation]"
    end
  end
end
