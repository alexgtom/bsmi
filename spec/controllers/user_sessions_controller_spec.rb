require 'spec_helper'

describe UserSessionsController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  describe "GET new" do
    it "assigns a new user_session as @user_session" do
      get :new, {}, valid_session
      assigns(:user_session).should be_a_new(User_session)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User_session" do
        expect {
          post :create, {:user_session => valid_attributes}, valid_session
        }.to change(User_session, :count).by(1)
      end

      it "assigns a newly created user_session as @user_session" do
        post :create, {:user_session => valid_attributes}, valid_session
        assigns(:user_session).should be_a(User_session)
        assigns(:user_session).should be_persisted
      end

      it "redirects to the created user_session" do
        post :create, {:user_session => valid_attributes}, valid_session
        response.should redirect_to(User_session.last)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user_session" do
      user_session = User_session.create! valid_attributes
      expect {
        delete :destroy, {:id => user_session.to_param}, valid_session
      }.to change(User_session, :count).by(-1)
    end

    it "redirects to the user_sessions list" do
      user_session = User_session.create! valid_attributes
      delete :destroy, {:id => user_session.to_param}, valid_session
      response.should redirect_to(user_sessions_url)
    end
  end
end
