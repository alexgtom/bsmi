require 'spec_helper'

describe SelectTimeslotsController do
  before(:each) do
    @preference = mock_model(Preference)
    @preference.stub(:delete)
    @preference.stub(:ranking=)
    @preference.stub(:save!)
    @preference.stub(:save)

    @preferences.stub(:find_by_id).and_return(@preference)
    @preferences.stub(:order).and_return([@preference])
    @student = mock_model(Student)
    @student.stub(:preferences).and_return(@preferences)
    @student.stub(:save)


  end

  it 'should show the timeslots available for that day' do
    Student.should_receive(:find).with("1").and_return(@student)
    Timeslot.should_receive(:where).with(:day => 1).and_return(mock('timeslot'))
    get :show, {:id => :monday, :student_id => 1}
  end

  it 'should show the ranking for the timeslots for the choices the student picked' do
    Student.should_receive(:find).with("1").and_return(@student)
    get :show, {:id => :rank, :student_id => 1}
  end

  it 'should show a summary of all the student\'s timeslot rankings' do
    Student.should_receive(:find).with("1").and_return(@student)
    get :show, {:id => :summary, :student_id => 1}
  end

  it 'should process the rankings entered by the student' do
    Student.should_receive(:find).and_return(@student)
    Preference.should_receive(:find_by_id).and_return(@preference) 
    put :update, {:id => :rank, :student_id => 1, :student => {:preferences_attributes => {1 => {:id => 1}}}}
  end

  it 'should process the timeslots entered by the student' do
    Student.should_receive(:find).with("1").and_return(@student)
    Preference.should_receive(:where).and_return([@preference]) 
    controller.stub(:params).and_return({:step => :monday, :monday => ['1'], :student_id => "1"})
    put :update, {:id => :monday, :student_id => 1}
  end
end
