require 'spec_helper'

describe MentorTeacher::SchedulesController do
  before(:each) do
    
    @teacher = FactoryGirl.create(:mentor_teacher) 
    #Session mocking
    MentorTeacher::SchedulesController.any_instance.stub(:current_teacher => @teacher)
    MentorTeacher::SchedulesController.any_instance.stub(:current_user => @teacher.user)
  end
  
  def valid_attributes
    FactoryGirl.attributes_for_list(:timeslot, 4)
  end

  def timeslot_post_data
    JSON.dump(@timeslots.map {|t| t.to_cal_event_hash})
  end
  
  def valid_session
    {}
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates all of the specified timeslots" do
        expect {
          post :create, {:timeslots => valid_attributes}, valid_session
        }.to change(Timeslot, :count).by(valid_attributes.length)        
      end

      it "assigns all the created timeslots to the current teacher" do
        timeslots = valid_attributes.map{|attrs| Timeslot.create(attrs)}
        Timeslot.stub(:new).and_return(*timeslots)
        post :create, {:timeslots => timeslot_post_data}, valid_session
        @teacher.timeslots.should == timeslots
      end
    end

    describe "with invalid params" do
      it "redirects back to the new path" do
        post :create, {:timeslots => []}
      end
    end
  end

  describe "GET edit" do
    it "assigns the timeslots for the current teacher as @timeslots" do
      fake_timeslots = ["t1", "t2"]
      @teacher.stub(:timeslots).and_return(fake_timeslots)
      get :edit
      assigns(:timeslots).should eq(fake_timeslots)
    end
  end
end
