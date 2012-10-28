require 'spec_helper'

describe School do

  describe "districts association" do
    before(:each) do
      #xxx TODO: abstract this better
      @district1, @district2 = FactoryGirl.create_list(:district, 2)
      @school = FactoryGirl.create(:school, :district => @district1)
    end

    it "should assign a district properly on creation" do      
      school = School.find(@school.id)
      school.district.should eq(@district1)
    end
    

    it "should update districts properly" do
      @school.district = @district2
      @school.save
      School.find(@school.id).district.should eq(@district2)
    end
  end

end
