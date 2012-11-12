require 'spec_helper'



describe "The matching solution" do

  before(:each) do
    @solver = MatchingSolver.new(preferences)
  end

  shared_examples_for "a good matching:" do
    
    let(:students) { Set.new(preferences.map {|p| p.student_id}) }
    let(:timeslots) { Set.new(preferences.map {|p| p.timeslot_id}) }

    it "should match every student to exactly one timeslot" do

      counts = Hash.new(0) 
      subject.each do |pref|
        counts[pref.student_id] += 1
      end
      students.each do |s|
        counts[s].should eq(1), "Student #{s} wasn't matched"
      end
    end



    it "should match every timeslot to a student who preferred it"
    it "should have the correct matching score"

  end

  subject { @solver.solve }
  context "in a simple example" do
    let(:preferences) do
      #s1 -> t1, t2
      #s2 -> t1
      #s3 -> t2, t3
      prefs = []
      [1,2].each do |i|
        prefs << FactoryGirl.build_stubbed(:preference, 
                                           :student_id => 0,
                                           :timeslot_id => i
                                           ) 
      end
      [1].each do |i|
        prefs << FactoryGirl.build_stubbed(:preference, 
                                           :student_id => 1,
                                           :timeslot_id => i
                                           ) 
      end

      [2,3].each do |i|
        prefs << FactoryGirl.build_stubbed(:preference, 
                                           :student_id => 2,
                                           :timeslot_id => i
                                           ) 
      end
      prefs
      
    end
    it_behaves_like "a good matching:"
  end

end
