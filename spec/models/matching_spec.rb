require 'spec_helper'

######################################################################################
# These tests are fairly pure unit tests for Matching, and as such don't 
# actually solve any linear programs (in an effort to test the behavior of each
# method in isolation. For proper integration tests (which will hit the linear solver)
# see spec/integration/matching_spec
######################################################################################
 
describe MatchingBackend::MatchingSolver do  
  let(:preferences) { FactoryGirl.build_stubbed_list(:preference, 4) }
  before(:each) do
    students = Set.new(preferences.map{|p| p.student})
    timeslots = Set.new(preferences.map{|p| p.timeslot})
    @solver = MatchingBackend::MatchingSolver.new(preferences, students, timeslots)
  end
  
  describe :solve do
    let(:preferences) {[]}
    before(:each) do
      @test_res = "test"
      @problem_mock = mock(:problem, :solution => @test_res)
      @solver.stub(:extract_solution)
    end

    it "should instantiate a new MatchingProblem" do
      MatchingBackend::MatchingProblem.should_receive(:new).and_return {@problem_mock}
      @solver.solve
    end

    it "should extract the problems solution" do
      MatchingBackend::MatchingProblem.stub(:new) {@problem_mock}
      @solver.should_receive(:extract_solution).with(@test_res)
      @solver.solve
    end

    it "should normalize the graph" do
      MatchingBackend::MatchingProblem.stub(:new) {@problem_mock}
      @solver.should_receive(:normalize_graph)
      @solver.solve
    end
  end
  
  describe :expand_timeslots do
    
    before(:each) do
      @timeslots = [FactoryGirl.build_stubbed(:timeslot, :max_num_assistants => 2),
                    FactoryGirl.build_stubbed(:timeslot, :max_num_assistants => 1)]
      @students = FactoryGirl.build_stubbed_list(:student, 3)
      
      @preferences = @timeslots.zip(@students).map do |t, s|        
        FactoryGirl.build_stubbed(:preference, :student => s,
                                        :timeslot => t)        
      end
      
      @solver = MatchingBackend::MatchingSolver.new(@preferences, @students, @timeslots)
    end

    it "should add nodes for each timeslot up to its maximum" do
      @solver.graph.should_receive(:add_node).exactly(1).times
      @solver.expand_timeslots
    end

    it "should add edges to the new from all students with edges to the original" do
      @solver.graph.should_receive(:add_edge).exactly(1).times
      @solver.expand_timeslots      
    end
  end
end

describe MatchingBackend::BipartiteGraph do  
  before(:each) do
    @graph = MatchingBackend::BipartiteGraph.new
  end
  
  describe :add_node do
    context "the node being added is already in the graph" do
      before(:each) do
        @graph.add_node(2, :student)
      end

      it "shouldn't place a new node in the adjacency list", :focus => true do
        @graph.add_node(2, :student)
        @graph.adjacency_list.length.should be 1
      end
    end

    context "graph is empty" do
      it "shouldn't place a new node in the adjacency list" do
        @graph.add_node(2, :student)
        @graph.adjacency_list.length.should be 1
      end
    end
  end

  describe :connect do
    before(:each) do
      @graph = MatchingBackend::BipartiteGraph.new

      @student_nodes = 2.times.map{|i| @graph.add_node(i, :student)}
      @timeslot_nodes = 2.times.map{|i| @graph.add_node(i, :timeslot)}

      @student_nodes.zip(@timeslot_nodes).each do |s, t|
        @graph.add_edge(s, t)
      end
    end

    it "should add edges only between unconnected nodes" do
#      @graph.connected?(@student_nodes[0], @timeslot_nodes[1]).should be false
      @graph.connect
      @graph.num_edges.should be 4
    end

    it "should add edges with dummy weights" do
      @graph.connect
      dummy_edge_weight = MatchingBackend::BipartiteGraph::DUMMY_EDGE_WEIGHT
      Set.new(@graph.edges.map{|e| e.weight}).should == 
        Set.new([1,1] + [dummy_edge_weight, dummy_edge_weight])
    end
  end

  describe "connected?" do

    before(:each) do
      @graph = MatchingBackend::BipartiteGraph.new
      @student_node = @graph.add_node(2, :student)
      @timeslot_node = @graph.add_node(4, :timeslot)
    end
    it "should return true when there is an edge between s and t" do
      @graph.add_edge(@student_node, @timeslot_node)
      @graph.connected?(@student_node, @timeslot_node).should be true
    end

    it "should return false when there is no edge between s and t" do
      @graph.connected?(@student_node, @timeslot_node).should be false
    end
  end


end
describe MatchingBackend::MatchingProblem do
  let(:preferences) { FactoryGirl.build_stubbed_list(:preference, 4) }
  before(:each) do
    @graph = MatchingBackend::BipartiteGraph.new
    students = Set.new(preferences.map{|p| p.student})
    preferences.each do |p|
      s_node = @graph.add_node(p.student, :student)
      t_node = @graph.add_node(p.student, :timeslot)
      @graph.add_edge(s_node, t_node, p.ranking)
    end
    #Instantiate a problem with params specified by the specific test cases
    @problem = MatchingBackend::MatchingProblem.new(@graph)      
  end

  describe :solution do
    before(:each) do
      @problem.stub(:simplex)
      @problem.stub(:prepare_problem)      
    end
    #TODO: come up with some good way of abstracting this for methods
    def do_call
      @problem.solution
    end
    context "even when there are no preferences" do
      let(:preferences) { [] }
      it "should cache its result" do
        @problem.stub(:cols).and_return([])
        do_call
        @problem.instance_variables.should include :@solution
      end
    end      
    context "when there are preferences" do
      let(:preferences) { FactoryGirl.build_stubbed_list(:preference, 4) }
      it "should return all preferences where the corresponding variable is nonzero" do  

        edges = 4.times.map{ mock(:edge) }
        @problem.graph.stub(:edges).and_return(edges)
        desired_cols = 2.times.map{ mock(:col, :get_prim => 1) }
        undesired_cols = 2.times.map { mock(:col, :get_prim => 0) }
        @problem.stub(:cols).and_return(desired_cols + undesired_cols)
        @problem.solution.should eq(edges[0..(desired_cols.length - 1)])
      end
    end
  end
  
  describe :initialize_objective do
    def do_call
      @problem.initialize_objective
    end
    
    it "should minimize its objective" do
      do_call
      @problem.obj.dir.should be Rglpk::GLP_MIN
    end

    it "should have coefficients of the preference rankings" do
      do_call
      @problem.obj.coefs.zip(preferences) do |coef, pref|
        coef.should eq(pref)
      end
    end
  end

  describe :initialize_vars do      
    def do_call
      @problem.initialize_vars
    end
    it "should add a variable for each preference" do
      @problem.should_receive(:add_cols).with preferences.length
      do_call
    end

    it "should constrain each var to be between zero and 1" do
      fake_cols = 3.times.map { mock(:col, :name= => true) }
      fake_cols.each {|r| r.should_receive(:set_bounds).with(Rglpk::GLP_DB, 0, 1)}
      @problem.stub(:cols).and_return(fake_cols)
      do_call
    end
  end

  describe :initialize_constraints do
    let(:preferences) { FactoryGirl.build_stubbed_list(:preference, 4) }

    before(:each) do
      @problem.stub(:set_matrix)
    end

    def do_call
      @problem.initialize_constraints
    end

    it "should add a row for each timeslot and each student" do
      students = Set.new(preferences.map {|p| p.student_id})
      timeslots = Set.new(preferences.map {|p| p.timeslot_id})
      
      @problem.should_receive(:add_rows).with(students.length + timeslots.length)
      do_call
    end

    it "should set the constraints matrix for the problem" do
      @problem.stub(:constraints_matrix).and_return([])
      @problem.should_receive(:set_matrix).with([])
      do_call
    end

    it "should constrain each row to be in between 0 and 1" do
      fake_rows = 3.times.map { mock(:row) }
      fake_rows.each {|r| r.should_receive(:set_bounds).with(Rglpk::GLP_FX, 1, 1)}
      @problem.stub(:rows).and_return(fake_rows)
      do_call
    end
  end

  describe :constraints_matrix do
    let(:preferences) { FactoryGirl.build_stubbed_list(:preference, 4) }

    def do_call
      @problem.constraints_matrix
    end

    it "should contain a row for each student" do
      students = Set.new(preferences.map {|p| p.student_id})
      @problem.should_receive(:constraints_row_for_student).exactly(students.length).times
      do_call
    end

    it "should contain a row for each timeslot" do
      timeslots = Set.new(preferences.map {|p| p.timeslot_id})
      @problem.should_receive(:constraints_row_for_timeslot).exactly(timeslots.length).times
      do_call
    end

  end

  shared_examples_for "a constraint row" do

    before(:each) do 
      @problem.graph.stub(:edges).and_return(4.times.map{ mock(:edge)})
           
      @problem.graph.edges.each.with_index do |e, i|
        e.stub(constraint_type).and_return(i)
      end
    end

    def do_call(id_for_type)
      @problem.send("constraints_row_for_#{constraint_type}".to_sym, id_for_type)
    end

    it "should contain 1's where the student has a preference for a timeslot and zeroes otherwise" do
      res = do_call(2)
      res.should == [0,0,1,0]
    end
  end

  describe :constraints_row_for_student do
    it_behaves_like "a constraint row" do
      let(:constraint_type) { :student }
    end
  end

  describe :constraints_row_for_timeslot do
    it_behaves_like "a constraint row" do
      let(:constraint_type) { :timeslot }
    end

  end


end

