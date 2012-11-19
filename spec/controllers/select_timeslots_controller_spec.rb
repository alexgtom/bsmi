require 'spec_helper'

describe SelectTimeslotsController do
  before(:each) do
    @student = FactoryGirl.create(:student)
    @timeslot = FactoryGirl.create(:timeslot)
    @preference = FactoryGirl.create(:preference)
    @cal_course = FactoryGirl.create(:cal_course)
  end

  it 'should show the timeslots available for that day' do
    Student.should_receive(:find).and_return(@student)
    Timeslot.should_receive(:where).with(:day => 1, :cal_course_id => @cal_course.id.to_s)
    get :show, {:id => :monday, :student_id => 1, :cal_course_id => @cal_course.id}
  end

  it 'should show the ranking for the timeslots for the choices the student picked' do
    Student.should_receive(:find).and_return(@student)
    get :show, {:id => :rank, :student_id => 1, :cal_course_id => @cal_course.id}
  end

  it 'should show a summary of all the student\'s timeslot rankings' do
    Student.should_receive(:find).and_return(@student)
    get :show, {:id => :summary, :student_id => 1, :cal_course_id => @cal_course.id}
  end

  it 'should process the rankings entered by the student' do
    Student.should_receive(:find).and_return(@student)
    put :update, {:id => :rank, :student_id => 1, :cal_course_id => @cal_course.id, :student => {:preferences_attributes => {1 => {:id => @preference.id }}}}
  end
  
  describe 'should process the timeslots entered by the student' do
    describe 'when a preference exists'
      it 'when "Save" is pressed' do
        Student.should_receive(:find).and_return(@student)
        Preference.should_receive(:where).and_return([@preference]) 
        put :update, {:id => :monday, :student_id => @student.id, :cal_course_id => @cal_course.id, :monday => [@timeslot.id], :commit => 'Save'}
      end

      it 'when "Save & Continue" is pressed' do
        Student.should_receive(:find).and_return(@student)
        Preference.should_receive(:where).and_return([@preference]) 
        put :update, {:id => :monday, :student_id => @student.id, :cal_course_id => @cal_course.id, :monday => [@timeslot.id], :commit => 'Save & Continue'}
      end
  end
end
