require 'spec_helper'

describe "user_sesions/show" do
  before(:each) do
    @user_sesion = assign(:user_sesion, stub_model(UserSesion,
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
