require 'spec_helper'
=begin
describe "cal_courses/show" do
  before(:each) do
    @cal_course = assign(:cal_course, stub_model(CalCourse,
      :name => "Name",
      :course_grade => "CourseGrade",
      :school_type => "SchoolType",
      :id => 1
    ))
    course = assign(:course, stub_model(Course, 
      :name => "Course Name",
      :grade => "Course Grade",
      :id => 1,
      :cal_course_id => 1,
    ))
    user = assign(:user, stub_model(User, :first_name => 'Greg', :last_name => 'Mar', :owner_id => '1', :email => "co@co.com", :password => "1234", :password_confirmation => "1234").should_receive(:name).and_return("Greg Mar"))
    mentor = assign(:mentor_teacher, stub_model(MentorTeacher, :shool => 'El Cerrito', :id => '1'))
    @times = [assign(:timeslot, stub_model(Timeslot, 
      :day => 1,
      :start_time => Time.new(2008,6,21, 9,30,0, "+09:00"),
      :end_time => Time.new(2008,6,21, 10,30,0, "+09:00"),
      :course_id => 1,
      :cal_course_id => 1
    ).should_receive(:to_string).and_return("monday|09:00AM|09:00AM").should_receive(:course).and_return(course))]
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/CourseGrade/)
    rendered.should match(/SchoolType/)
  end
end
=end
