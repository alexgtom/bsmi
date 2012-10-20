require 'spec_helper'

describe SelectTimeslotsController do
  it 'should show the timeslots available for that day' do
    Student.should_receive(:find_by_id).with(1).and_return(mock('student'))
    get :show, {:id => :monday, :student_id => 1}
  end
end
