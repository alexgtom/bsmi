require 'spec_helper'

describe CalCourse do
  before(:each) do
    sd = mock_model(CalCourse)
    ss = mock_model(School)
    sc = mock_model(Course)
    smt = mock_model(MentorTeacher)
    st = mock_model(Timeslot)
    st.stub!(:build_entry).with(1).and_return({"school_level"=>"Elementary School", "school_name"=>"Berkeley High", "teacher"=>"mt_first mt_last", "time"=>"monday|10:00AM|10:30AM", "time_id"=>1, "course"=>sc, "grade"=>"6", "checked"=>true})
  end

  describe "create selection" do

    it "assigns all entries to cal_courses as @cal_courses" do
      #Pre
      sample_result = {"school_level"=>"Elementary School", "school_name"=>"Berkeley High", "teacher"=>"mt_first mt_last", "time"=>"monday|10:00AM|10:30AM", "time_id"=>1, "course"=>sc, "grade"=>"6", "checked"=>true}
      Timeslot.stub!(:All).and_return(st)

      Timeslot.should_receive(:All).and_return(st)
      assigns(:entries).should eq([sample_result])
    end

    it "assigns all entries to cal_courses as @cal_courses" do
      #Pre
      Timeslot.stub!(:All).and_return(nil)

      Timeslot.should_receive(:All).and_return(nil)
      assigns(:entries).should eq([])
    end
  end
end
