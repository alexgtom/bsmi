require 'spec_helper'

describe "The matching solution" do


  let(:students) { Set.new(preferences.map {|p| p.student}) }
  let(:timeslots) { Set.new(preferences.map {|p| p.timeslot}) }

  before(:each) do
    @solver = MatchingSolver.new(preferences, students, timeslots)
  end

  shared_examples_for "a good matching:" do
    
    it "should match every student to exactly one timeslot" do
      counts = Hash.new(0) 
      subject.each do |matching|
        counts[matching.student_id] += 1
      end
      students.each do |s|
        counts[s.id].should eq(1), "Student #{s} wasn't matched"
      end
    end

    it "should match every timeslot to at least one student" do
      counts = Hash.new(0) 
      subject.each do |matching|
        counts[matching.timeslot_id] += 1
      end
      timeslots.each do |t|
        counts[t.id].should be >= 1, "Timeslot #{t} wasn't matched"
        counts[t.id].should be <= t.max_num_assistants, "Timeslot #{t} was matched too many times"
      end
    end


    it "should have the correct matching score" do
      matching_score.should eq(desired_matching_score)
    end

  end

  subject { @solver.solve }
  context "in a simple example" do
    let(:preferences) do
      build_preferences(:s1 => [[:t1, 1], [:t2, 2]],
                        :s2 => [[:t1, 1]])
#                        :s3 => [[:t2, 1], [:t3, 2]])      
    end
    let(:desired_matching_score) { 3 }
    
    it_behaves_like "a good matching:", 
  end

  context "when everyone has the same preferences" do
    let(:preferences) do
      build_preferences(:s1 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                        :s2 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                        :s3 => [[:t1, 1], [:t2, 2], [:t3, 3]])
    end
    let(:desired_matching_score) { 6 }
    
    it_behaves_like "a good matching:"
  end

  context "when everyone has a different first choice",  do
    let(:preferences) do
      build_preferences(:s1 => [[:t1, 1], [:t2, 2]],
                        :s2 => [[:t2, 1], [:t3, 2]],
                        :s3 => [[:t3, 1], [:t2, 2]])
    end
    let(:desired_matching_score) { 3 }
    
    it_behaves_like "a good matching:"
  end

  context "when some students need to be paired" do
    let(:preferences) do
      build_preferences( {:s1 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                          :s2 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                          :s3 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                          :s4 => [[:t1, 1], [:t2, 2], [:t3, 3]]},
                         {:t2 => {:max_num_assistants => 2}}
                        )
    end
    #8 is actual cost of matching; add offset b/c dup node chosen
    let(:desired_matching_score) { 8 + BipartiteGraph::DUP_EDGE_OFFSET } 

    it_behaves_like "a good matching:" 
  end


  context "when pairing would otherwise give a lower score" do
    let(:preferences) do
      build_preferences({ :s1 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                          :s2 => [[:t1, 1], [:t2, 2], [:t3, 3]],
                          :s3 => [[:t1, 1], [:t2, 2], [:t3, 3]]
                        },
                        {:t1 => {:max_num_assistants => 2}})
                        
    end

    it "should pair only as needed" do
      counts = Hash.new(0) 
      subject.each do |matching|
        counts[matching.timeslot_id] += 1
      end
      timeslots.each do |t|
        counts[t.id].should eq(1)
      end
    end
    let(:desired_matching_score) { 6 }
    it_behaves_like "a good matching:"
  end


  #####################################################
  # Non perfect matchings
  #####################################################

  context "when a good matching is impossible" do

    let(:preferences) do
      build_preferences(:s1 => [[:t1, 1], [:t2, 2]],
                        :s2 => [[:t1, 2], [:t2, 1]],
                        :s3 => [[:t1, 1]])
    end

    it "still gives the lowest score possible" do
      matching_score.should eq(2)
    end

    it "should match as many people as possible" do
      subject.length.should eq(2)
    end

  end

##################################################
# Helpers
##################################################

  # Construct a list of preferences from preference_hash
  #
  #preference_hash: Hash mapping students to lists of timeslot-ranking pairs.
  #Both students and timeslots can be represented by any symbol.
  #
  # Sample use:       
  #     build_preferences(:s1 => [[:t1, 1], [:t2, 2]],
  #                       :s2 => [[:t2, 1], [:t2, 2]],
  #                       :s3 => [[:t3, 1], [:t2, 2]])

  def build_preferences(preference_hash, timeslot_options = {}) 
    prefs = []

    student_objs = Hash.new
    timeslot_objs = Hash.new

    preference_hash.each_pair do |student_name, ts_ranking_pairs|
      student_objs[student_name] = FactoryGirl.build_stubbed(:student)
      
      ts_ranking_pairs.each do |pair|
        timeslot_name, ranking = pair                        

        if not timeslot_objs.include? timeslot_name
          options_for_timeslot = timeslot_options[timeslot_name] || {}
          timeslot_objs[timeslot_name] = FactoryGirl.build_stubbed(:timeslot,
                                                                   options_for_timeslot
                                                                   )
        end
        
      end
    end

    preference_hash.each_pair do |student_name, ts_ranking_pairs|
      ts_ranking_pairs.each do |pair|
        timeslot_name, ranking = pair                        
        prefs << FactoryGirl.build_stubbed(:preference,
                                           :student => student_objs[student_name],
                                           :timeslot => timeslot_objs[timeslot_name],
                                           :ranking => ranking)
      end
    end
    return prefs
  end


  def matching_score
    subject.map {|p| p.ranking}.reduce(:+)
  end

end
