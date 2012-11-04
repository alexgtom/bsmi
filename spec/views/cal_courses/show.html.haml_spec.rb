require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @cal_course = assign(:cal_course, stub_model(CalCourse,
      :name => "Name",
      :course_grade => "Grade",
      :school_type => "School Type",
      :id => 1
    ))
    course = assign(:course, stub_model(Course, 
      :name => "Course Name"
      :grade => "Course Grade"
      :id => '1'
    ))
    user = assign(:user, stubmodel(User, :name => 'Greg', :owner_id => '1'))
    mentor = assign(:mentor_teacher, stubmodel(MentorTeacher, :shool => 'El Cerrito', :id => '1'))
    @times = [assign(:timeslot, stub_model(Timeslot, 
      :start_time => Time.new(2008,6,21, 9,30,0, "+09:00")
      :end_time => Time.new(2008,6,21, 10,30,0, "+09:00")
      :course_id => '1'
      :cal_course_id => '1'
    ))]
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/CourseGrade/)
    rendered.should match(/SchoolType/)
  end
end
