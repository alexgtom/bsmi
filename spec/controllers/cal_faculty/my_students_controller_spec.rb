require 'spec_helper'

describe CalFaculty::MyStudentsController do
  def valid_attributes
    {:first_name => 'myname', :last_name => 'mylastname', :street_address => 'myaddress', :city => 'mycity', :state => 'CA', :zipcode => '90000', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456', :owner_id => 1, :owner_type => 'CalFaculty'}
  end

  def valid_session
    { }
  end
  describe "GET index" do
    it "list all my(cal_faculty) assigned students" do
      @passing_params = {:sort => nil}    
      student = FactoryGirl.create(:student)
      user = FactoryGirl.create(:cal_faculty)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user.user)
      user.should_receive(:students).and_return([student])
      CalFaculty.should_receive(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_students).should eq([student])
    end
    it "list all sort by first_name" do
      @passing_params = {:sort => "first_name"}    
      student = FactoryGirl.create(:student)
      user = FactoryGirl.create(:cal_faculty)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user.user)
      user.should_receive(:students).and_return([student])
      CalFaculty.should_receive(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_students).should eq([student])
    end
    it "list all sort by last_name" do
      @passing_params = {:sort => "last_name"}    
      student = FactoryGirl.create(:student)
      user = FactoryGirl.create(:cal_faculty)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user.user)
      user.should_receive(:students).and_return([student])
      CalFaculty.should_receive(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_students).should eq([student])
    end
  end
end
