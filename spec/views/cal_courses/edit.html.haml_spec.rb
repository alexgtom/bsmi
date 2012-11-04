require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @cal_course = assign(:cal_course, stub_model(CalCourse,
      :name => "MyString",
      :grade => "MyString",
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cal_courses_path(@cal_course), :method => "post" do
      assert_select "input#cal_course_name", :name => "cal_course[name]"
      assert_select "input#cal_course_grade", :name => "cal_course[grade]"
    end
  end
end
