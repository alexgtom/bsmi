require 'spec_helper'

describe "user_sesions/new" do
  before(:each) do
    assign(:user_sesion, stub_model(UserSesion,
      :email => "MyString",
      :password => "MyString"
    ).as_new_record)
  end

  it "renders new user_sesion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_sesions_path, :method => "post" do
      assert_select "input#user_sesion_email", :name => "user_sesion[email]"
      assert_select "input#user_sesion_password", :name => "user_sesion[password]"
    end
  end
end
