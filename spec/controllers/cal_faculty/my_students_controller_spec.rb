require 'spec_helper'

describe CalFaculty::MyStudentsController do
  def valid_attributes
    {:first_name => 'myname', :last_name => 'mylastname', :street_address => 'myaddress', :city => 'mycity', :state => 'CA', :zipcode => '90000', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456', :owner_id => 1, :owner_type => 'CalFaculty'}
  end

  def valid_session
    { }
  end
  describe "GET index" do
    it "list all my(cal_faculty) assigned mentor_teachers" do
      @passing_params = {:sort => nil}    
      user = User.create! valid_attributes
      user.should_receive(:owner_id).and_return(user.id)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user)
      user.should_receive(:students).and_return([user])
      CalFaculty.stub!(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_students).should eq([user])
    end
    it "list all sorted by first_name" do
      @passing_params = {:sort => "first_name"}    
      user = User.create! valid_attributes
      user.should_receive(:owner_id).and_return(user.id)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user)
      user.should_receive(:students).and_return([user])
      user.should_receive(:user).and_return(user)
      CalFaculty.stub!(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_students).should eq([user])
    end
    it "list all sorted by last_name" do
      @passing_params = {:sort => "last_name"}    
      user = User.create! valid_attributes
      user.should_receive(:owner_id).and_return(user.id)
      controller.stub!(:require_cal_faculty).and_return(true)
      controller.stub!(:current_user).and_return(user)
      user.should_receive(:students).and_return([user])
      user.should_receive(:user).and_return(user)
      CalFaculty.stub!(:find).and_return(user)
      get :index, @passing_params, valid_session
      assigns(:my_students).should eq([user])
    end
  end
end
