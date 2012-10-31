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


  shared_examples "a page allowing changes to a schedule" do
    before(:each) do
      get action_under_test
    end
    it "should assign @read_only to false" do
      assigns(:read_only).should eq(false)
    end

    it "should assign submit_link appropriately" do
      assigns(:submit_link).should eq(desired_submit_path)
    end    

    it "should assign the current timeslots appropriately" do
      assigns(:timeslots).should eq(desired_timeslots)
    end            

    it "should assign the form method appropriately" do
      assigns(:method).should eq(desired_method)
    end            

  end


  describe "GET new" do
    context "when the user already has a schedule" do
      before(:each) do
        fake_timeslots = [mock(:timeslot, :to_cal_event_hash => :res)]
        @teacher.stub(:timeslots).and_return(fake_timeslots)        
      end

      it "should redirect the user to the edit page" do        
        get :new
        response.should redirect_to edit_mentor_teacher_schedule_path
      end
    end
    
    context "when the user doesn't have a schedule" do
      it "should render normally" do
        get :new 
        response.should render_template "mentor_teacher/schedules/edit_or_new"
      end  

      it_behaves_like "a page allowing changes to a schedule" do
        let(:action_under_test) { :new }
        let(:desired_submit_path) { mentor_teacher_schedule_path }
        let(:desired_timeslots) { [] }
        let(:desired_method) { :post }
      end
    end
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

  shared_examples "a view of timeslots" do
    it "assigns the timeslots for the current teacher as @timeslots in calEvent form" do
      get action_under_test
      assigns(:timeslots).should eq(@teacher.timeslots.map{|t| t.to_cal_event_hash})
    end
  end

  describe "GET show" do
    context "user has no timeslots" do
      it "should redirect to new" do
        get :show
        response.should redirect_to new_mentor_teacher_schedule_path
      end
    end

    context "user has timeslots" do
      before(:each) do
        fake_timeslots = [mock(:timeslot, :to_cal_event_hash => :res)]
        @teacher.stub(:timeslots).and_return(fake_timeslots)        
      end
      
      it_behaves_like "a view of timeslots" do
        let(:action_under_test) { :show }
      end

      it "assigns readonly to true for the calendar" do
        get :show
        assigns(:read_only).should eq(true)
      end
    end
  end

  describe "GET edit" do
    context "teacher has timeslots" do
      #TODO: refactor this into shared concert
      before(:each) do
        fake_timeslots = [mock(:timeslot, :to_cal_event_hash => :res)]
        @teacher.stub(:timeslots).and_return(fake_timeslots)        
      end
      it_behaves_like "a view of timeslots" do
        let(:action_under_test) { :edit }
      end

      it_behaves_like "a page allowing changes to a schedule" do
        let(:action_under_test) { :edit }

        let(:desired_submit_path) { mentor_teacher_schedule_path }
        let(:desired_timeslots) { @teacher.timeslots.map{|t| t.to_cal_event_hash} }
        let(:desired_method) { :put }
      end

      it "should render the edit_or_new form" do
        get :edit
        response.should render_template "mentor_teacher/schedules/edit_or_new"
      end
    end

    context "teacher has no timeslots" do
      it "should redirect to new" do
        get :edit
        response.should redirect_to new_mentor_teacher_schedule_path
      end
    end
  end

  describe "PUT update" do

    before(:each) do
      @timeslots = FactoryGirl.create_list(:timeslot, 2, :mentor_teacher => @teacher) 
    end

    shared_examples_for "an updater for timeslots" do
      it "should update the appropriate timeslots with new values" do
        changed_timeslots_data = timeslots_to_change.map do |t|
          FactoryGirl.build(:cal_event_hash, 
                            :id => t.id,
                            :start => t.start_time + 3600
                            ) #end is set by factory to an ok value)                    
        end

        put :update, :timeslots => JSON.dump(changed_timeslots_data)
        timeslots_to_change.zip(changed_timeslots_data).each do |actual, expected|
          actual.start_time.should eq(expected[:start])
        end
      end
    end

    context "when all timeslots exist for the current teacher" do      
      it_should_behave_like "an updater for timeslots" do
        let(:timeslots_to_change) { @timeslots[0..1] }
      end
    end

    context "when some timeslots are new for the current teacher" do
      @new_timeslot_hash = FactoryGirl.build(:cal_event_hash, :db_id => nil)
      let(:put_data) do
        @timeslots + [@new_timeslot_hash]
      end
      it_should_behave_like "an updater for timeslots" do
        let(:timeslots_to_change) { @timeslots }
      end
      it "should create new timeslots for those not already in the db" do
        Timeslot.should_receive(:from_cal_event_json).with(JSON.dump(@new_timeslot_hash))
        put :update, :timeslots => JSON.dump(put_data)
      end
    end

    context "when an event needs to be destroyed" do
      
      context "and the event exists for this teacher," do
        it "should delete the event" do
          Timeslot.any_instance.should_receive(:delete)
          put_data = @timeslots.first.to_cal_event_hash
          put_data["destroy"] = true
          put :update, :timeslots => JSON.dump([put_data])
        end

      end

      context "and the event doesn't exist for this teacher" do

        it "shouldn't delete anything" do
          Timeslot.any_instance.should_not_receive(:delete)
          put_data = @timeslots.first.to_cal_event_hash
          @timeslots.first.mentor_teacher = nil
          @timeslots.first.save
          put_data["destroy"] = true
          put :update, :timeslots => JSON.dump([put_data])

        end
      end

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
