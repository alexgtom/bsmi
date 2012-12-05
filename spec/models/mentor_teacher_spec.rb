require 'spec_helper'

describe MentorTeacher do
  it {should have_many :timeslots}
  it {should have_one(:user)}

  describe :timeslots_for_semester do
    
    before(:each) do
      @teacher = FactoryGirl.create(:mentor_teacher)
      @semester1, @semester2 = FactoryGirl.create_list(:semester, 2)
      @cal_courses = [FactoryGirl.create(:cal_course, :semester => @semester1),
                      FactoryGirl.create(:cal_course, :semester => @semester2)]

      @desired_timeslots = FactoryGirl.create_list(:timeslot, 2, 
                                                   :mentor_teacher => @teacher,
                                                   :cal_course => @cal_courses[0]
                                                   )
      FactoryGirl.create_list(:timeslot, 2,
                              :mentor_teacher => @teacher,
                              :cal_course => @cal_courses[1])
    end
    
    it "should return exactly the timeslots in this semester" do
      @teacher.timeslots_for_semester(@semester1.id).should eq(@desired_timeslots)
    end
  end
end
