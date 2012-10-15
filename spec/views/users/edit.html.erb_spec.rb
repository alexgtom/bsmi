require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "MyString",
      :address => "MyString",
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
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_address", :name => "user[address]"
      assert_select "input#user_phone_number", :name => "user[phone_number]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_crypted_password", :name => "user[crypted_password]"
      assert_select "input#user_persistence_token", :name => "user[persistence_token]"
    end
  end
end
