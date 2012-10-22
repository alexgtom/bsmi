require 'spec_helper'

describe UsersController do

  def valid_attributes
    {:name => 'myname', :address => 'myaddress', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456'}
  end

  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      controller.stub!(:require_user).and_return(user)
      controller.stub!(:current_user).and_return(user)
      get :show
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      controller.stub!(:require_user).and_return(user)
      controller.stub!(:current_user).and_return(user)
      get :edit
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created yser as @user" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the signup page" do
        post :create, {:user => valid_attributes}, valid_session
        response.should redirect_to(signup_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved student as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => {}}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => user.to_param, :user => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested student as @user" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the student" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {}}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

end
