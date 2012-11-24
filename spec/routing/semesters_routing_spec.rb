require "spec_helper"

describe SemestersController do
  describe "routing" do

    it "routes to #index" do
      get("/semesters").should route_to("semesters#index")
    end

    it "routes to #new" do
      get("/semesters/new").should route_to("semesters#new")
    end

    it "routes to #show" do
      get("/semesters/1").should route_to("semesters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/semesters/1/edit").should route_to("semesters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/semesters").should route_to("semesters#create")
    end

    it "routes to #update" do
      put("/semesters/1").should route_to("semesters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/semesters/1").should route_to("semesters#destroy", :id => "1")
    end

  end
end
