require "spec_helper"

describe MentorTeachersController do
  describe "routing" do

    it "routes to #index" do
      get("/mentor_teachers").should route_to("mentor_teachers#index")
    end

    it "routes to #new" do
      get("/mentor_teachers/new").should route_to("mentor_teachers#new")
    end

    it "routes to #show" do
      get("/mentor_teachers/1").should route_to("mentor_teachers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mentor_teachers/1/edit").should route_to("mentor_teachers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mentor_teachers").should route_to("mentor_teachers#create")
    end

    it "routes to #update" do
      put("/mentor_teachers/1").should route_to("mentor_teachers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mentor_teachers/1").should route_to("mentor_teachers#destroy", :id => "1")
    end

  end
end
