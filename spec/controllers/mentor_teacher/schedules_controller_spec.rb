require 'spec_helper'

describe MentorTeacher::SchedulesController do
  before(:each) do
    
    @teacher = FactoryGirl.create(:mentor_teacher) 
    #Session mocking
    MentorTeacher::SchedulesController.any_instance.stub(:current_teacher => @teacher)
    MentorTeacher::SchedulesController.any_instance.stub(:current_user => @teacher.user)
  end
  
  def valid_attributes
    if @valid_attributes.nil? 
      @valid_attributes = FactoryGirl.attributes_for_list(:timeslot, 4)
    else
      @valid_attributes
    end
  end

  def timeslot_post_data
    valid_attributes.map do |t| 
      JSON.dump(      
                {"id" => t[:id],
                  #TODO: format this elsewhere
                  "start" => t[:start_time].utc.iso8601,
                  "end" => t[:end_time].utc.iso8601,
                  "title" => t[:class_name]
                }
              )
    end
  end
  
  def valid_session
    {}
  end

  describe "POST create" do
    def do_create
      post :create, {:timeslots => timeslot_post_data}, valid_session
    end

    describe "with valid params" do
      it "creates all of the specified timeslots" do
       expect {
          do_create
       }.to change(Timeslot, :count).by(valid_attributes.length)        

      end

      it "should redirect to mentor_teacher_schedule_path" do
        do_create
        response.should redirect_to mentor_teacher_schedule_path
      end

      it "assigns all the created timeslots to the current teacher" do
        timeslots = valid_attributes.map{|attrs| Timeslot.create(attrs)}
        Timeslot.stub(:new).and_return(*timeslots)
        do_create
        @teacher.timeslots.should == timeslots
      end
    end

    describe "with invalid params" do
  
      it "redirects back to the new path" do
        post :create, {:timeslots => [""]}

        response.should redirect_to new_mentor_teacher_schedule_path

        
      end
    end
  end

  describe "GET show" do
    it "assigns the timeslots for the current teacher as @timeslots" do
      fake_timeslots = ["t1", "t2"]
      @teacher.stub(:timeslots).and_return(fake_timeslots)
      get :show
      assigns(:timeslots).should eq(fake_timeslots)
    end

  end

  # describe "GET edit" do
  #   it "assigns the timeslots for the current teacher as @timeslots" do
  #     fake_timeslots = ["t1", "t2"]
  #     @teacher.stub(:timeslots).and_return(fake_timeslots)
  #     get :edit
  #     assigns(:timeslots).should eq(fake_timeslots)
  #   end
  # end
end
