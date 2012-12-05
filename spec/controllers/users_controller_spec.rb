require 'spec_helper'

describe UsersController do

  def valid_attributes
    {:first_name => 'myname', :last_name => 'mylastname', :street_address => 'myaddress', :city => 'mycity', :state => 'CA', :zipcode => '90000', :phone_number => '123-456-7890', :email => 'my@email.com', :password => '123456', :password_confirmation => '123456', :owner_type => 'Student'}
  end

  def valid_session
    { }
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
      before(:each) do
        @passing_params = {:user => valid_attributes, :owner_type => valid_attributes[:owner_type], :invite_code => 'inv_code'}
        @user_type = User.user_types[valid_attributes[:owner_type]]
        @invite = true
        @invite.should_receive(:email).and_return("my@email.com")
        @invite.should_receive(:owner_type).and_return("Student")
        @invite.should_receive(:redeemed!).and_return(true)
        Invite.stub!(:find_redeemable).and_return(@invite)
      end
      it "creates a new User" do
        expect {
          post :create, @passing_params, valid_session
        }.to change(User, :count).by(1)
      end

      it "creates a new owner of the appropriate type" do
        expect {
          post :create, @passing_params, valid_session
        }.to change(@user_type, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, @passing_params, valid_session
        assigns(:user).should be_a(User)
      end

      it "assigns the owner field of the new user to the new owner" do        
        owner = @user_type.new
        @user_type.stub(:new => owner)
        post :create, @passing_params, valid_session

        assigns(:user).owner.should == owner
      end

      it "redirects to user profile page" do
        post :create, @passing_params, valid_session
        response.should redirect_to(assigns(:user))
      end
    end
    
    shared_examples_for "an invalid create request" do
      describe "with invalid params" do
        it "assigns a newly created but unsaved student as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => bad_params}, valid_session
          assigns(:user).should be_a_new(User)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => bad_params}, valid_session
          response.should render_template("new")
        end
      end      
    end

    describe "with an invalid user" do
      it_should_behave_like "an invalid create request" do
        let(:bad_params)  {{}}
      end
    end

  
    describe "with an invalid owner type" do
      it_should_behave_like "an invalid create request" do
        let(:bad_params)  {valid_attributes.merge(:owner_type => 'Foo')}
      end
    end

    describe "with an invalid invite_code" do
      it "should render the new page" do
        @passing_params = {:user => valid_attributes, :owner_type => valid_attributes[:owner_type]}
        @user_type = User.user_types[valid_attributes[:owner_type]]
        @invite = true
        Invite.stub!(:find_redeemable).and_return(@invite)

        post :create, @passing_params, valid_session
        response.should render_template("new")
      end
    end

    describe "with an error on saving" do
      it "should render the new page" do
        @passing_params = {:user => valid_attributes, :owner_type => valid_attributes[:owner_type], :invite_code => 'inv_code'}
        @user_type = User.user_types[valid_attributes[:owner_type]]
        @invite = true
        @invite.should_receive(:email).and_return("my@email.com")
        @invite.should_receive(:owner_type).and_return("Student")
        Invite.stub!(:find_redeemable).and_return(@invite)

        User.any_instance.stub(:save).and_return(false)

        post :create, @passing_params, valid_session
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

  describe "GET adv_new" do
    before (:each) do
      controller.stub!(:require_user_type).and_return(true)
    end
    it "assigns a new user as @user" do
      get :adv_new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST adv_create" do
    before (:each) do
      controller.stub!(:require_user_type).and_return(true)
    end
    describe "with valid params" do
      before(:each) do
        @passing_params = {:user => valid_attributes}
        @user_type = User.user_types[valid_attributes[:owner_type]]
      end
      it "creates a new User" do
        expect {
          post :adv_create, @passing_params, valid_session
        }.to change(User, :count).by(1)
      end

      it "creates a new owner of the appropriate type" do
        expect {
          post :adv_create, @passing_params, valid_session
        }.to change(@user_type, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :adv_create, @passing_params, valid_session
        assigns(:user).should be_a(User)
      end

      it "assigns the owner field of the new user to the new owner" do        
        owner = @user_type.new
        @user_type.stub(:new => owner)
        post :adv_create, @passing_params, valid_session

        assigns(:user).owner.should == owner
      end

      it "redirects to student lists" do
        post :adv_create, @passing_params, valid_session
        response.should redirect_to("/students")
      end
    end
    
    shared_examples_for "an invalid create request for adv_create" do
      describe "with invalid params" do
        it "assigns a newly created but unsaved student as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :adv_create, {:user => bad_params}, valid_session
          assigns(:user).should be_a_new(User)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :adv_create, {:user => bad_params}, valid_session
          response.should render_template("adv_new")
        end
      end      
    end

    describe "with an invalid user" do
      it_should_behave_like "an invalid create request for adv_create" do
        let(:bad_params)  {{}}
      end
    end

  
    describe "with an invalid owner type" do
      it_should_behave_like "an invalid create request for adv_create" do
        let(:bad_params)  {valid_attributes.merge(:owner_type => 'Foo')}
      end
    end


    describe "with an error on saving" do
      it "should render the new page" do
        @passing_params = {:user => valid_attributes}
        @user_type = User.user_types[valid_attributes[:owner_type]]

        User.any_instance.stub(:save).and_return(false)

        post :adv_create, @passing_params, valid_session
        response.should render_template("adv_new")
      end
    end
  end

  describe "GET adv_edit" do
    before (:each) do
      controller.stub!(:require_user_type).and_return(true)
    end
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      controller.stub!(:require_user).and_return(user)
      controller.stub!(:current_user).and_return(user)
      get :adv_edit, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "PUT adv_update" do
    before (:each) do
      controller.stub!(:require_user_type).and_return(true)
    end
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :adv_update, {:id => user.to_param, :user => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested student as @user" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        put :adv_update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the student" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        put :adv_update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to("/students")
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :adv_update, {:id => user.to_param, :user => {}}, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        controller.stub!(:require_user).and_return(user)
        controller.stub!(:current_user).and_return(user)
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :adv_update, {:id => user.to_param, :user => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end  
  describe "DELETE destroy" do
    before (:each) do
      controller.stub!(:require_user_type).and_return(true)
    end
    describe "should destroy a user" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        User.any_instance.stub(:destroy).and_return(true)
        delete :destroy, {:id => user.to_param}, valid_session
        response.should redirect_to("/students")
      end
    end
  end
end
