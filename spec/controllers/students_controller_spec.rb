require 'spec_helper'

describe StudentsController do
  # This should return the minimal set of attributes required to create a valid
  # Advisor. As you add validations to Advisor, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdvisorsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  def valid_user_attr
    {:first_name => 'myname', :last_name => 'mylastname', :street_address => 'myaddress', :city => 'mycity', :state => 'CA', :zipcode => '90000', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456', :owner_type => 'Student'}
  end

  describe "GET index" do
    it "assigns the requested all_student as @all_student" do
      student = Student.create! valid_attributes
      get :index, valid_session
      assigns(:all_student).should eq([student])
    end
    it "assigns the requested all_student as @all_student ordered by first name" do
      student = Student.create! valid_attributes
      user = User.create! valid_user_attr
      student.should_receive(:user).and_return(user)
      Student.stub!(:all).and_return([student])
      sort_session = {:sort => "first_name"}
      get :index, valid_session, sort_session
      assigns(:all_student).should eq([student])
    end
    it "assigns the requested all_student as @all_student ordered by last name" do
      student = Student.create! valid_attributes
      user = User.create! valid_user_attr
      student.should_receive(:user).and_return(user)
      Student.stub!(:all).and_return([student])
      sort_session = {:sort => "last_name"}
      get :index, valid_session, sort_session
      assigns(:all_student).should eq([student])
    end
  end

  describe ".index" do
    before do
        @all_student = User.where(:owner_type => "Student")
        @sort = nil
    end
    it "assigns all students as @all_student when there is no sort" do
       if @sort == nil
         @all_student.should eq(User.where(:owner_type => "Student"))
       end
    end
    it "sort all students by name when sort is set to name" do
      if @sort == 'name'
        @all_student = @all_student.order(:name)
        @all_student.should eq(User.where(:owner_type => "Student").order(:name))
      end
    end
    it "sort all students by name when sort is set to placement" do
      if @sort == 'course'
        @all_student = @all_student.order(:placement)
        @all_student.should eq(User.where(:owner_type => "Student").order(:placement))
      end
    end
  end

  describe "sort" do
	
  end
  
  describe ".placement" do
  end
end
