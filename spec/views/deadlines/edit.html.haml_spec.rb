require 'spec_helper'

describe "deadlines/edit" do
  before(:each) do
    @deadline = assign(:deadline, stub_model(Deadline,
      :title => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders the edit deadline form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deadlines_path(@deadline), :method => "post" do
      assert_select "input#deadline_title", :name => "deadline[title]"
      assert_select "textarea#deadline_summary", :name => "deadline[summary]"
    end
  end
end
