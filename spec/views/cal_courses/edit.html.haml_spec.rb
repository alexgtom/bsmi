require 'spec_helper'

describe "cal_courses/edit" do
  before(:each) do
    @cal_course = assign(:cal_course, stub_model(CalCourse,
      :name => "MyString",
      :course_grade => "8",
      :school_type => "Elementary School"
    ))
    @entries = []
  end

  it "renders the edit cal_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cal_courses_path(@cal_course), :method => "post" do
      assert_select "input#cal_course_name", :name => "cal_course[name]"
      assert_select "select#cal_course_course_grade", :name => "cal_course[course_grade]"
    end
  end
end
