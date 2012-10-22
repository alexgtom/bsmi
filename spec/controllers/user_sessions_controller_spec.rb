require 'spec_helper'

describe UserSessionsController do

  def valid_attributes
    {:email => "my@email.com", :password => "1234"}
  end

  def valid_session
    {}
  end

  describe "GET new" do
    it "assigns a new user_session as @user_session" do
      get :new, {}, valid_session
      assigns(:user_session).should be_a_new(UserSession)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User_session" do
        UserSession.any_instance.stub(:save).and_return(true)
        post :create, {:user_session => valid_attributes}, valid_session
      end

      it "assigns a newly created user_session as @user_session" do
        post :create, {:user_session => valid_attributes}, valid_session
        assigns(:user_session).should be_a(UserSession)
        assigns(:user_session).should be_persisted
      end

      it "redirects to the created user_session" do
        post :create, {:user_session => valid_attributes}, valid_session
        response.should redirect_to(UserSession.last)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user_session" do
      user_session = mock({:id => "1"})
      controller.stub!(:require_user).and_return(true)
      controller.stub!(:current_user).and_return(true)
      controller.stub!(:current_user_session) { |arg|
        double(' ').tap { |arg2|
          arg2.stub!(:destroy).and_return(true)
        }
      }
      delete :destroy
      response.should redirect_to(controller.new_user_session_url)
    end
  end
end
