require 'spec_helper'

describe CalFaculty::MyMentorTeachersController do
  def valid_session
    { }
  end
  describe "GET index" do
    it "list all my(cal_faculty) assigned mentor_teachers" do
      @passing_params = {:sort => nil}    
      mentor_teacher = FactoryGirl.create(:mentor_teacher)
      user = FactoryGirl.create(:cal_faculty)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user.user)
      course = true
      course.should_receive(:mentor_teachers).and_return([mentor_teacher])
      user.should_receive(:students).and_return([course])
      CalFaculty.should_receive(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_faculties).should eq([mentor_teacher])
    end
    it "list all sort by first_name" do
      @passing_params = {:sort => "first_name"}    
      mentor_teacher = FactoryGirl.create(:mentor_teacher)
      user = FactoryGirl.create(:cal_faculty)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user.user)
      course = true
      course.should_receive(:mentor_teachers).and_return([mentor_teacher])
      user.should_receive(:students).and_return([course])
      CalFaculty.should_receive(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_faculties).should eq([mentor_teacher])
    end
    it "list all sort by last_name" do
      @passing_params = {:sort => "last_name"}    
      mentor_teacher = FactoryGirl.create(:mentor_teacher)
      user = FactoryGirl.create(:cal_faculty)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user.user)
      course = true
      course.should_receive(:mentor_teachers).and_return([mentor_teacher])
      user.should_receive(:students).and_return([course])
      CalFaculty.should_receive(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_faculties).should eq([mentor_teacher])
    end
  end
end
