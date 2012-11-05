require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
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
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
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
