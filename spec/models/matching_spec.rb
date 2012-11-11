require 'spec_helper'

######################################################################################
# These tests are fairly pure unit tests for MatchingSolver, and as such don't 
# actually solve any linear programs (in an effort to test the behavior of each
# method in isolation. For proper integration tests, which will hit the linear solver,
# see features/matching.feature
######################################################################################
 
describe MatchingSolver do
  let(:preferences) { FactoryGirl.build_stubbed_list(:preference, 4) }
  before(:each) do
    @solver = MatchingSolver.new(preferences)
  end
  describe :solve do
    let(:preferences) {[]}
    before(:each) do
      @test_res = "test"
      @problem_mock = mock(:problem, :solution => @test_res)
    end

    it "should instantiate a new MatchingProblem" do
      MatchingSolver::MatchingProblem.should_receive(:new).and_return {@problem_mock}
      @solver.solve
    end

    it "should return the problems solution" do
      MatchingSolver::MatchingProblem.stub(:new) {@problem_mock}
      @solver.solve.should eq(@test_res)
    end
  end

  describe MatchingSolver::MatchingProblem do
    before(:each) do
      #Instantiate a problem with params specified by the specific test cases
      @problem = MatchingSolver::MatchingProblem.new(preferences)      
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
          desired_cols = 2.times.map{ mock(:col, :get_prim => 1) }
          undesired_cols = 2.times.map { mock(:col, :get_prim => 0) }
          @problem.stub(:cols).and_return(desired_cols + undesired_cols)
          @problem.solution.should eq(preferences[0..(desired_cols.length - 1)])
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
        fake_rows.each {|r| r.should_receive(:set_bounds).with(Rglpk::GLP_UP, 0, 1)}
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
      let(:id_for_type) { 2 }
      let(:prefs_for_type) { FactoryGirl.build_stubbed_list(:preference, 3, 
                                         "#{constraint_type}_id".to_sym => id_for_type) }
      let(:preferences) do 
        prefs_for_type + FactoryGirl.build_stubbed_list(:preference, 5)
      end

      def do_call
        @problem.send("constraints_row_for_#{constraint_type}".to_sym, id_for_type)
      end

      it "should contain 1's where the student has a preference for a timeslot and zeroes otherwise" do
        res = do_call
        student_pref_set = Set.new(prefs_for_type) {|p| p.id}
        res.zip(preferences) do |res_val, p|
          if student_pref_set.include? p.id 
            res_val.should be 1
          else
            res_val.should be 0
          end
        end
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
end
