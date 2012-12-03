require 'spec_helper'

describe "user_sessions/new.html.haml" do
  before(:each) do
    Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self)
    @user_session = assign(:user_session, stub_model(UserSession,
      :session_id => "sessionid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Password/)
  end
end
