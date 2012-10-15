require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :name => "Name",
        :address => "Address",
        :phone_number => "Phone Number",
        :email => "Email",
        :crypted_password => "Crypted Password",
        :persistence_token => "Persistence Token"
      ),
      stub_model(User,
        :name => "Name",
        :address => "Address",
        :phone_number => "Phone Number",
        :email => "Email",
        :crypted_password => "Crypted Password",
        :persistence_token => "Persistence Token"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Crypted Password".to_s, :count => 2
    assert_select "tr>td", :text => "Persistence Token".to_s, :count => 2
  end
end
