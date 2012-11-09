require 'rglpk'

class MatchingSolver
  attr_accessor :preferences, :students, :timeslots
  def initialize(preferences)
    self.preferences = preferences
    self.students = Set.new(preferences.map {|p| p.student_id}).to_a
    self.timeslots = Set.new(preferences.map {|p| p.timeslot_id}).to_a
  end

  def solve
    problem = MatchingProblem.new(preferences, students, timeslots)
    return problem.solution
  end


  class MatchingProblem < Rglpk::Problem
    
    attr_reader :students, :timeslots, :preferences

    def initialize(preferences, students, timeslots)
      @preferences = preferences
      @students = students
      @timeslots = timeslots

      self.initialize_vars
      self.initialize_constraints
      self.initialize_objective
    end

    def solution
      #Use cached solution if possible
      if @solution
        return @solution
      end
      
      self.simplex
      @solution = self.preferences.zip(self.cols).find_all{|p, col| col.get_prim > 0 }.
        map { |p, col| p }      

      return @solution
    end

    def initialize_objective
      self.obj.dir = Rglpk::GLP_MIN
      self.obj.coefs = self.preferences.map {|p| p.ranking}
    end

    def initialize_vars 
      self.add_cols(self.preferences.length)
      self.cols.zip(self.preferences).each do |col, pref|
        col.name = "match_#{pref.student_id}_#{pref.timeslot_id}"
      end
    end

    def initialize_constraints
      self.add_rows(self.students.length + self.timeslots.length)
      self.rows.each do |r|
        r.set_bounds(Rglpk::GLP_UP, 0, 1)
      end
      
      self.set_matrix(self.constraints_matrix.flatten)
    end
    
    #Provide the constraints matrix for the linear program. Each row in the matrix
    #corresponds either to a constraint on a timeslot or on a student.  
    def constraints_matrix    
      (self.students.map {|s| constraints_row_for_student s} +
       self.timeslots.map {|t| constraints_row_for_timeslot t})
    end

    def constraints_row_for_student(student_id)
      self.preferences.map do |p|
        if p.student_id == student_id
          1
        else
          0
        end
      end    
    end

    def constraints_row_for_timeslot(timeslot_id)
      self.preferences.map do |p|
        if p.timeslot_id == timeslot_id
          1
        else
          0
        end
      end    
    end
  end
end  

