require 'spec_helper'

describe ApplicationController do
  describe "require_user" do
    it "returns nil if current_user exists" do
      current_user = mock("i am the user")
      controller.stub!(:current_user).and_return(current_user)
      controller.instance_eval{ require_user }
      controller.instance_eval{ @require_user }.should eq(nil)
    end
    it "returns false if current_user doesn't exist" do
      controller.stub!(:current_user).and_return(false)
      controller.instance_eval{ require_user }
      controller.instance_eval{ @require_user }.should eq(false)
    end
  end

  describe "require_no_user" do
    it "returns false if current_user doesn't exist" do
      current_user = mock("i am the user")
      controller.stub!(:current_user).and_return(current_user)
      controller.instance_eval{ require_no_user }
      controller.instance_eval{ @require_no_user }.should eq(false)
    end
    it "returns nil if current_user exists" do
      controller.stub!(:current_user).and_return(nil)
      controller.instance_eval{ require_no_user }
      controller.instance_eval{ @require_no_user }.should eq(nil)
    end
  end

  describe "redirect_back_or_default" do
    it "redirects to :return_to or default and set session to nil" do
      session.stub(:[]).with(:return_to).and_return("/")
      controller.instance_eval{ redirect_back_or_default(nil) }
      response.should redirect_to("/")
    end
  end
end
