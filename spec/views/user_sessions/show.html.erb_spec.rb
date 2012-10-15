require 'spec_helper'

describe "user_sessions/show" do
  before(:each) do
    @user_session = assign(:user_session, stub_model(UserSession,
      :email => "Email",
      :password => "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Password/)
  end
end
