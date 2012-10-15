require 'spec_helper'

describe "user_sesions/edit" do
  before(:each) do
    @user_sesion = assign(:user_sesion, stub_model(UserSesion,
      :email => "MyString",
      :password => "MyString"
    ))
  end

  it "renders the edit user_sesion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_sesions_path(@user_sesion), :method => "post" do
      assert_select "input#user_sesion_email", :name => "user_sesion[email]"
      assert_select "input#user_sesion_password", :name => "user_sesion[password]"
    end
  end
end
