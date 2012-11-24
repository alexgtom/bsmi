require 'spec_helper'

describe "semesters/new" do
  before(:each) do
    assign(:semester, stub_model(Semester,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new semester form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => semesters_path, :method => "post" do
      assert_select "select#semester_name", :name => "semester[name]"
    end
  end
end
