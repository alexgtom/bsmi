require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "Name",
      :address => "Address",
      :phone_number => "Phone Number",
      :email => "Email",
      :crypted_password => "Crypted Password",
      :persistence_token => "Persistence Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Login count/)
    rendered.should match(/Last request at/)
    rendered.should match(/Last login at/)
    rendered.should match(/Current login at/)
    rendered.should match(/Last login ip/)
    rendered.should match(/Current login ip/)
  end
end
