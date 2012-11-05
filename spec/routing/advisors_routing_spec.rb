require "spec_helper"

describe AdvisorsController do
  describe "routing" do

    it "routes to #index" do
      get("/advisors").should route_to("advisors#index")
    end

    it "routes to #new" do
      get("/advisors/new").should route_to("advisors#new")
    end

    it "routes to #show" do
      get("/advisors/1").should route_to("advisors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advisors/1/edit").should route_to("advisors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advisors").should route_to("advisors#create")
    end

    it "routes to #update" do
      put("/advisors/1").should route_to("advisors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advisors/1").should route_to("advisors#destroy", :id => "1")
    end

  end
end
