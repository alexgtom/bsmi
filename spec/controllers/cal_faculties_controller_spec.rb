require 'spec_helper'

describe CalFacultiesController do

  def create_cal_faculty
    FactoryGirl.create(:cal_faculty)
  end

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  
  describe "GET index" do
    it "assigns the requested all_faculties as @all_faculties" do
      faculties = CalFaculty.create! valid_attributes
      User.stub!(:where).and_return(faculties)
      get :index, valid_session
      assigns(:all_faculties).should eq(faculties)
    end
    it "assigns the requested all_faculties as @all_faculties ordered by first name" do
      faculties = CalFaculty.create! valid_attributes
      faculties.should_receive(:order).and_return(faculties)
      User.stub!(:where).and_return(faculties)
      sort_session = {:sort => "first_name"}
      get :index, valid_session, sort_session
      assigns(:all_faculties).should eq(faculties)
    end
    it "assigns the requested all_faculties as @all_faculties ordered by last name" do
      faculties = CalFaculty.create! valid_attributes
      faculties.should_receive(:order).and_return(faculties)
      User.stub!(:where).and_return(faculties)
      sort_session = {:sort => "last_name"}
      get :index, valid_session, sort_session
      assigns(:all_faculties).should eq(faculties)
    end
  end

  describe "GET show" do
    it "assigns the requested cal_faculty as @cal_faculty" do
      cal_faculty = create_cal_faculty
      get :show, {:id => cal_faculty.to_param}, valid_session
      assigns(:cal_faculty).should eq(cal_faculty)
    end
  end

  describe "GET new" do
    it "assigns a new cal_faculty as @cal_faculty" do
      get :new, {}, valid_session
      assigns(:cal_faculty).should be_a_new(CalFaculty)
    end
  end

  describe "GET edit" do
    it "assigns the requested cal_faculty as @cal_faculty" do
      cal_faculty = create_cal_faculty
      get :edit, {:id => cal_faculty.to_param}, valid_session
      assigns(:cal_faculty).should eq(cal_faculty)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CalFaculty" do
        expect {
          post :create, {:cal_faculty => valid_attributes}, valid_session
        }.to change(CalFaculty, :count).by(1)
      end

      it "assigns a newly created cal_faculty as @cal_faculty" do
        post :create, {:cal_faculty => valid_attributes}, valid_session
        assigns(:cal_faculty).should be_a(CalFaculty)
        assigns(:cal_faculty).should be_persisted
      end

      it "redirects to the created cal_faculty" do
        post :create, {:cal_faculty => valid_attributes}, valid_session
        response.should redirect_to(CalFaculty.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cal_faculty as @cal_faculty" do
        # Trigger the behavior that occurs when invalid params are submitted
        CalFaculty.any_instance.stub(:save).and_return(false)
        post :create, {:cal_faculty => {}}, valid_session
        assigns(:cal_faculty).should be_a_new(CalFaculty)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CalFaculty.any_instance.stub(:save).and_return(false)
        post :create, {:cal_faculty => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cal_faculty" do
        cal_faculty = create_cal_faculty
        # Assuming there are no other mentor_teachers in the database, this
        # specifies that the create_cal_faculty
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CalFaculty.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => cal_faculty.to_param, :cal_faculty => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested cal_faculty as @cal_faculty" do
        cal_faculty = create_cal_faculty
        put :update, {:id => cal_faculty.to_param, :cal_faculty => valid_attributes}, valid_session
        assigns(:cal_faculty).should eq(cal_faculty)
      end

      it "redirects to the cal_faculty" do
        cal_faculty = create_cal_faculty
        put :update, {:id => cal_faculty.to_param, :cal_faculty => valid_attributes}, valid_session
        response.should redirect_to(cal_faculty)
      end
    end

    describe "with invalid params" do
      it "assigns the cal_faculty as @cal_faculty" do
        cal_faculty = create_cal_faculty
        # Trigger the behavior that occurs when invalid params are submitted
        CalFaculty.any_instance.stub(:save).and_return(false)
        put :update, {:id => cal_faculty.to_param, :cal_faculty => {}}, valid_session
        assigns(:cal_faculty).should eq(cal_faculty)
      end

      it "re-renders the 'edit' template" do
        cal_faculty = create_cal_faculty
        # Trigger the behavior that occurs when invalid params are submitted
        CalFaculty.any_instance.stub(:save).and_return(false)
        put :update, {:id => cal_faculty.to_param, :cal_faculty => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cal_faculty" do
      cal_faculty = create_cal_faculty
      expect {
        delete :destroy, {:id => cal_faculty.to_param}, valid_session
      }.to change(CalFaculty, :count).by(-1)
    end

    it "redirects to the cal_faculty list" do
      cal_faculty = create_cal_faculty
      delete :destroy, {:id => cal_faculty.to_param}, valid_session
      response.should redirect_to(cal_faculties_url)
    end
  end

end
