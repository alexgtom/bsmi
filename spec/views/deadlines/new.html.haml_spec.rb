require 'spec_helper'

describe "deadlines/new" do
  before(:each) do
    assign(:deadline, stub_model(Deadline,
      :title => "MyString",
      :summary => "MyText"
    ).as_new_record)
  end

  it "renders new deadline form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deadlines_path, :method => "post" do
      assert_select "input#deadline_title", :name => "deadline[title]"
      assert_select "textarea#deadline_summary", :name => "deadline[summary]"
    end
  end
end
