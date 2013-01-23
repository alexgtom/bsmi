require 'spec_helper'

describe ApplicationController do
  describe "require_user" do
    it "returns true if current_user exists" do
      current_user = mock("i am the user")
      controller.stub!(:current_user).and_return(current_user)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_user }
      @returned.should eq(nil)
    end
    it "returns false if current_user doesn't exist" do
      controller.stub!(:current_user).and_return(false)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_user }
      @returned.should eq(false)
    end
  end

  describe "require_no_user" do
    it "returns false if current_user exists" do
      current_user = mock("i am the user")
      controller.stub!(:current_user).and_return(current_user)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_no_user }
      @returned.should eq(false)
    end
    it "returns nil if current_user doesn't exist" do
      controller.stub!(:current_user).and_return(nil)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_no_user }
      @returned.should eq(nil)
    end
  end

  describe "requier_admin" do
    it "returns true if owner_type of current_user is Advisor" do
      current_user = mock("i am the user")
      current_user.stub!(:owner_type).and_return("Advisor")
      controller.stub!(:current_user).and_return(current_user)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_admin }
      @returned.should eq(nil)
    end
    it "returns false if current_user does not exist or current_user.owner_type is not Advisor" do
      controller.stub!(:current_user).and_return(nil)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_admin }
      @returned.should eq(false)
    end
  end

  describe "requier_cal_faculty" do
    it "returns true if owner_type of current_user is CalFaculty" do
      current_user = mock("i am the user")
      current_user.stub!(:owner_type).and_return("CalFaculty")
      controller.stub!(:current_user).and_return(current_user)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_cal_faculty }
      @returned.should eq(nil)
    end
    it "returns false if current_user does not exist or current_user.owner_type is not CalFaculty" do
      controller.stub!(:current_user).and_return(nil)
      controller.stub!(:redirect_to).and_return(true)
      @returned = controller.instance_eval{ require_cal_faculty }
      @returned.should eq(false)
    end
  end

  describe "require_user_type" do
    before(:each) do
      @user = FactoryGirl.build_stubbed(:user, 
                                        :owner_type => owner_type,
                                        :owner_id => 2)
      controller.stub(:current_user => @user)
      controller.stub(:redirect_back_or_default)
    end

    def do_call
      controller.send(:require_user_type, desired_type)
    end

    context "when the user type is correct" do
      let(:owner_type) { "Student" }
      let(:desired_type) { "Student" }

      it "should do nothing" do        
        controller.should_not_receive(:redirect_back_or_default)
        do_call
      end
    end

    context "the user type is incorrect" do
      let(:owner_type) { "Student" }
      let(:desired_type) { "MentorTeacher" }

      it "should use redirect_back_or_default" do
        controller.should_receive(:redirect_back_or_default) 
        do_call
      end

      it "should set an error message in the notice" do        
        do_call
        flash[:notice].should_not eql(nil)
      end

    end



  end

  describe "redirect_back_or_default" do
    it "redirects to :return_to or default and set session to nil" do
      session[:return_to] = "redirecting somewhere"
      controller.stub!(:redirect_to).and_return(true)
      controller.instance_eval{ redirect_back_or_default(nil) }
      session[:return_to].should eq(nil)
    end
  end
end
