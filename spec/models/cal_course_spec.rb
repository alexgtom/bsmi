require 'spec_helper'
require 'set'
describe CalCourse do
  subject {FactoryGirl.create(:cal_course)}
  describe :match do

    before(:each) do
      #Builds students and timeslots as well
      @preferences = FactoryGirl.create_list(:preference, 4)
      
      @students = Set.new(@preferences.map {|p| p.student})
      @timeslots = Set.new(@preferences.map {|p| p.timeslot})

      subject.timeslots = @timeslots.to_a
      subject.students = @students.to_a

      
    end

    def do_call
      subject.match
    end
    it "should instantiate a solver with all preferences for this course" do
      Matching::MatchingSolver.should_receive(:new).with(@preferences,
                                                         subject.students,
                                                         subject.timeslots).
        and_return(mock(:matching_solver, :solve => []))
                                                                                 
      do_call
    end

    it "should create new placements from the results of matching" do
      solution = [{ :student_id => @students.first.id,
                    :timeslot_id => @timeslots.first.id
                  }]
      Matching::MatchingSolver.stub(:new).and_return(mock(:matching_solver, 
                                                          :solve => solution))
      
      do_call
      @students.first.placements.should include @timeslots.first
    end
  end

  describe :match_all do
    it "should match all Cal Courses" do
      mock_courses = [mock(:cal_course, :match => nil)]
      mock_courses.each {|c| c.should_receive(:match)}
      CalCourse.stub(:all).and_return(mock_courses)
      
      CalCourse.match_all
    end
  end
end
