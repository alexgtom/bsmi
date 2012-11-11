require 'spec_helper'

describe MatchingSolver do

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
      let(:preferences) { FactoryGirl.build_list(:preference, 8) }

      #TODO: come up with some good way of abstracting this for methods
      def do_call
        @problem.solution
      end
      
      it "should cache its result" do
        @problem.stub(:simplex)
        @problem.stub(:prepare_problem)
        @problem.stub(:cols).and_return([])
        do_call
        @problem.instance_variables.should include :@solution
      end
      
      it "should return all preferences where the corresponding variable is nonzero" do
        
        desired_cols = mock(:col, :get_prim => 1)
        @problem.stub(:cols).and_return(all_cols)
      end
    end
    
    describe :initialize_objective do

    end

    describe :initialize_vars do

    end

    describe :initialize_constraints do

    end

    describe :constraints_matrix do

    end

    describe :constraints_row_for_student do

    end

    describe :constraints_row_for_timeslot do

    end


  end
  # describe :constraints_matrix do
  #   shared_context

  #   it "should cache its results" do
  #     assigns(:constraints_matrix).should_not be_nil
  #   end

  #   it "should return a constraint matrix with 1's for every student, timeslot pair in preferences" do
      
  #   end
    
  # end



end
