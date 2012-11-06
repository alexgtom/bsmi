require 'spec_helper'

describe "cal_courses/new" do
  before(:each) do
    assign(:cal_course, stub_model(CalCourse,
      :name => "MyString",
      :course_grade => "8",
      :school_type => "Elementary School"
    ).as_new_record)
    @entries = []
  end

  it "renders new cal_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#cal_course_name", :name => "course[name]"
      assert_select "select#cal_course_course_grade", :name => "course[course_grade]"
    end
  end
end
