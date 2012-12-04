require 'spec_helper'

describe CalCoursesController do
  before(:each) do
    @semester = FactoryGirl.create(:semester)
  end

  def valid_attributes
    {:name => "Educ 1011", :school_type => "Elementary School", :semester_id => @semester.id}
  end

  def invalid_parameters_school
    {:name => "Educ 1011", :school_type => "All", :semester_id => @semester.id}
  end

  def valid_timeslots
    {}
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all cal_courses as @cal_courses" do
      cal_course = CalCourse.create! valid_attributes
      get :index, {}, valid_session
      assigns(:cal_courses).should eq([cal_course])
    end
  end

  describe "GET show" do
    it "assigns the requested cal_course as @cal_course" do
      cal_course = CalCourse.create! valid_attributes
      get :show, {:id => cal_course.to_param}, valid_session
      assigns(:cal_course).should eq(cal_course)
    end
  end

  describe "GET new" do
    it "assigns a new cal_course as @cal_course" do
      get :new, {}, valid_session
      assigns(:cal_course).should be_a_new(CalCourse)
    end
  end

  describe "GET edit" do
    it "assigns the requested cal_course as @cal_course" do
      cal_course = CalCourse.create! valid_attributes
      get :edit, {:id => cal_course.to_param}, valid_session
      assigns(:cal_course).should eq(cal_course)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CalCourse" do
        expect {
          post :create, {:cal_course => valid_attributes}, valid_session
        }.to change(CalCourse, :count).by(1)
      end

      it "assigns a newly created cal_course as @cal_course" do
        post :create, {:cal_course => valid_attributes}, valid_session
        assigns(:cal_course).should be_a(CalCourse)
        assigns(:cal_course).should be_persisted
      end

      it "redirects to the created cal_course" do
        post :create, {:cal_course => valid_attributes}, valid_session
        response.should redirect_to(CalCourse.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cal_course as @cal_course" do
        # Trigger the behavior that occurs when invalid params are submitted
        CalCourse.any_instance.stub(:save).and_return(false)
        post :create, {:cal_course => {}}, valid_session
        assigns(:cal_course).should be_a_new(CalCourse)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CalCourse.any_instance.stub(:save).and_return(false)
        post :create, {:cal_course => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cal_course" do
        cal_course = CalCourse.create! valid_attributes
        # Assuming there are no other cal_courses in the database, this
        # specifies that the CalCourse created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        semester = FactoryGirl.create(:semester)
        valid_attr = {"name" => "Educ 111", "school_type" => "Middle School", "semester_id" => cal_course.semester.id.to_s}
        valid_attr_put = {"name" => "Educ 111", "school_type" => "Middle School", "semester_id" => cal_course.semester.id.to_s}
        CalCourse.any_instance.should_receive(:update_attributes).with(valid_attr)
        put :update, {:id => cal_course.to_param, :cal_course => valid_attr_put, :timeslots => valid_timeslots}, valid_session
      end

      it "assigns the requested cal_course as @cal_course" do
        cal_course = CalCourse.create! valid_attributes
        put :update, {:id => cal_course.to_param, :cal_course => valid_attributes, :timeslots => valid_timeslots}, valid_session
        assigns(:cal_course).should eq(cal_course)
      end

      it "redirects to the cal_course" do
        cal_course = CalCourse.create! valid_attributes
        put :update, {:id => cal_course.to_param, :cal_course => valid_attributes, :timeslots => valid_timeslots}, valid_session
        response.should redirect_to (cal_course)
      end
    end

    describe "with invalid params" do
      it "assigns the cal_course as @cal_course" do
        cal_course = CalCourse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CalCourse.any_instance.stub(:save).and_return(false)
        put :update, {:id => cal_course.to_param, :cal_course => {}, :timeslots => valid_timeslots}, valid_session
        assigns(:cal_course).should eq(cal_course)
      end

      it "re-renders the 'edit' template if param for school type is uncorrect" do
        cal_course = CalCourse.create! invalid_parameters_school
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, {:id => cal_course.to_param, :cal_course => invalid_parameters_school, :timeslots => valid_timeslots, :semester => "1"}, valid_session
        response.should render_template("edit")
      end


      it "re-renders the 'edit' template" do
        cal_course = CalCourse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CalCourse.any_instance.stub(:save).and_return(false)
        put :update, {:id => cal_course.to_param, :cal_course => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cal_course" do
      cal_course = CalCourse.create! valid_attributes
      expect {
        delete :destroy, {:id => cal_course.to_param}, valid_session
      }.to change(CalCourse, :count).by(-1)
    end

    it "redirects to the cal_courses list" do
      cal_course = CalCourse.create! valid_attributes
      delete :destroy, {:id => cal_course.to_param}, valid_session
      response.should redirect_to(cal_courses_url)
    end
  end

end
