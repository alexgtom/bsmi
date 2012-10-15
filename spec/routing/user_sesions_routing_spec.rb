require "spec_helper"

describe UserSesionsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_sesions").should route_to("user_sesions#index")
    end

    it "routes to #new" do
      get("/user_sesions/new").should route_to("user_sesions#new")
    end

    it "routes to #show" do
      get("/user_sesions/1").should route_to("user_sesions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_sesions/1/edit").should route_to("user_sesions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_sesions").should route_to("user_sesions#create")
    end

    it "routes to #update" do
      put("/user_sesions/1").should route_to("user_sesions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_sesions/1").should route_to("user_sesions#destroy", :id => "1")
    end

  end
end
