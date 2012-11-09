describe MatchingSolver do
  describe :constraints_matrix do
    shared_context

    it "should cache its results" do
      assigns(:constraints_matrix).should_not be_nil
    end

    it "should return a constraint matrix with 1's for every student, timeslot pair in preferences" do
      
    end
    
  end



end
