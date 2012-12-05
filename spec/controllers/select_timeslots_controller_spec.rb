require 'spec_helper'

describe SelectTimeslotsController do
  before(:each) do
    @student = FactoryGirl.create(:student)
    @timeslot = FactoryGirl.create(:timeslot)
    @preference = FactoryGirl.create(:preference)
    @cal_course = FactoryGirl.create(:cal_course)
    @semester = FactoryGirl.create(:semester)
  end

  it 'should show the timeslots available for that day' do
    Semester.should_receive(:past_deadline?).and_return(false)
    Student.should_receive(:find).and_return(@student)
    #Timeslot.should_receive(:find_by_semester_id).with(@semester.id).and_return(mock_model())
    #Timeslot.should_receive(:where).and_return([@timeslot])
    Timeslot.stub_chain(:find_by_semester_id, :where).and_return([@timeslot])
    get :show, {:id => :monday, :semester_id => @semester.id, :student_id => @student.id, :cal_course_id => @cal_course.id}
  end

  it 'should show the ranking for the timeslots for the choices the student picked' do
    Semester.should_receive(:past_deadline?).and_return(false)
    Student.should_receive(:find).and_return(@student)
    get :show, {:id => :rank, :semester_id => @semester.id, :student_id => @student.id, :cal_course_id => @cal_course.id}
  end

  it 'should show a summary of all the student\'s timeslot rankings' do
    Semester.should_receive(:past_deadline?).and_return(false)
    Student.should_receive(:find).and_return(@student)
    get :show, {:id => :summary, :semester_id => @semester.id, :student_id => @student.id, :cal_course_id => @cal_course.id}
  end

  it 'should process the rankings entered by the student' do
    Semester.should_receive(:past_deadline?).and_return(false)
    Student.should_receive(:find).and_return(@student)
    put :update, {:id => :rank, :semester_id => @semester.id, :student_id => @student.id, :cal_course_id => @cal_course.id, :student => {:preferences_attributes => {1 => {:id => @preference.id }}}}
  end
  
  describe 'should process the timeslots entered by the student' do
    describe 'when a preference exists'
      it 'when "Save" is pressed' do
        Semester.should_receive(:past_deadline?).and_return(false)
        Student.should_receive(:find).and_return(@student)
        Preference.should_receive(:where).and_return([@preference]) 
        put :update, {:id => :monday, :semester_id => @semester.id, :student_id => @student.id, :cal_course_id => @cal_course.id, :monday => [@timeslot.id], :commit => 'Save'}
      end

      it 'when "Save & Continue" is pressed' do
        Semester.should_receive(:past_deadline?).and_return(false)
        Student.should_receive(:find).and_return(@student)
        Preference.should_receive(:where).and_return([@preference]) 
        put :update, {:id => :monday, :semester_id => @semester.id, :student_id => @student.id, :cal_course_id => @cal_course.id, :monday => [@timeslot.id], :commit => 'Save & Continue'}
      end
  end
end
