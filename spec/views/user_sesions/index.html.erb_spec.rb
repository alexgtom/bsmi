require 'spec_helper'

describe "user_sesions/index" do
  before(:each) do
    assign(:user_sesions, [
      stub_model(UserSesion,
        :email => "Email",
        :password => "Password"
      ),
      stub_model(UserSesion,
        :email => "Email",
        :password => "Password"
      )
    ])
  end

  it "renders a list of user_sesions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end
