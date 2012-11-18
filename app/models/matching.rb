require 'rglpk'
require 'set'

class BipartiteGraph
  attr_accessor :adjacency_list

#Need ways of determining: duplicate node, dummy node
  class Node
    attr_reader :value, :type

    def initialize(value, type, options = {})
      @value = value
      @type = type
      @dummy = options[:dummy] || false
      @duplicate = options[:duplicate] || false
    end

    def ==(other)
      if not other.instance_of? Node
        return false
      else
        return value == other.value and 
          type == other.type and
          @dummy == other.dummy? and
          @duplicate == other.duplicate?               
      end
    end

    def hash
      return value.hash
    end

    def dummy?
      return @dummy
    end

    def duplicate?
      return @duplicate
    end
  end

  def initialize(preferences=nil)
    self.adjacency_list = Hash.new {|hash, key| hash[key] = Hash.new}
    @sides = Hash[[:student, Set.new], [:timeslot, Set.new]]
    @sides.freeze

    @dummy_edges = Set.new
    if preferences
      preferences.each do |p| 
        self.add_edge(p.student_id, p.timeslot_id, p.ranking)
      end
    end
  end

  def add_node(value, type, options = {})
    unless @sides.include? type
      throw ArgumentError.new("#{type} isn't a valid type for the graph")
    end

    node = Node.new(value, type, options)
    @sides[type].add(node)

    unless self.adjacency_list.include? node
      self.adjacency_list[node] = Hash.new
    end

    return node
  end

  def timeslots
    return @sides[:timeslot]
  end

  def students
    return @sides[:student]
  end

  def equalize_sides
    if students.length == timeslots.length
      return
    end
    
    dummy_type = students.length > timeslots.length ? :timeslot : :student
    
    (students.length - timeslots.length).abs.times do |i|
        self.add_node(i, dummy_type, :dummy => true)
    end  
  end
  
  DUMMY_EDGE_WEIGHT = 10000
  #Fully connect the two sides of the graph
  #Any edges that didn't exist previously are added with a very high weight. This ensure 
  #that our algorithm will only pick these edges when there isn't a better option.
  def connect 
    self.students.each do |s|
      self.timeslots.each do |t|
        if not connected? s, t
          self.add_edge(s, t, DUMMY_EDGE_WEIGHT)
          @dummy_edges.add([s,t])
        end
      end
    end
  end

  def add_edge(student_node, timeslot_node, weight=1)
    self.adjacency_list[s][t] = weight
  end
  
  def connected?(s, t)
    return self.adjacency_list[s].include? t
  end

  def dummy_edge?(s,t)
    return @dummy_edges.include? [s,t]
  end

  def edge_weight(s,t)
    return self.adjacency_list[s][t]
  end
end

class MatchingSolver
  attr_reader :preferences
  def initialize(preferences)
    @preferences = preferences
    @students = Set.new(preferences.map {|p| p.student_id}).to_a
    @timeslots = Set.new(preferences.map {|p| p.timeslot_id}).to_a
  end

  def solve
    self.normalize_graph
    problem = MatchingProblem.new(preferences, students, timeslots)
    return problem.solution
  end

  #Problem: not enough teachers for students
  #Solution: make dummy nodes for timeslots that can accomodate more
  private

  def normalize_graph
    self.expand_timeslots
    self.graph.equalize_sides
    self.graph.connect
        
    #Goals
    #Equal numbers of teachers and students
    #Each timeslot duplicated up to max num students
    #Give everyone an edge to everything
    #If pick dummy edge for student, not actually matched

    #3 classes of dummy:
    # Dummy student to real timeslot = don't use timeslot
    # Real student to dummy timeslot = student is unmatched
    # Real student, real timeslot, dummy edge = student is unmatched

    # More students than timeslots:
    #   -> dummy timeslots

    # More timeslots than students:
    #   -> dummy students
    
    # Can't have both
  end

  #Split each timeslot into timeslot.max_num_assistant nodes, each of which can then
  #be matched separately
  def expand_timeslots
    timeslots_to_students = Hash.new {|hash, key| hash[key] = []}
    self.preferences.each do |p|
      timeslots_to_students[p.timeslot] << [p.student_id, p.ranking]
    end
    
    self.timeslots_to_students.each_pair do |timeslot, student_list|
      dup_nodes = (timeslot.max_num_assistants - 1).times.map do
        self.graph.add_node(timeslot.id, :timeslot, :duplicate => true)
      end
      
      dup_nodes.each do |dup_node|
        student_list.each do |student_id, ranking|        
          student_node = Graph::Node.new(student_id, :student)
          self.graph.add_edge(student_node, dup_node, ranking)
        end
      end
    end
  end


  def extract_solution(matchings)
    
  end
  #Represents an assignment problem instance between mentor teacher timeslots
  #and students. 
  class MatchingProblem < Rglpk::Problem
    
    attr_reader :students, :timeslots, :preferences

    def initialize(preferences, students, timeslots)           
      super()
      @preferences = preferences
      @students = students
      @timeslots = timeslots
    end
    
    def prepare_problem
      self.initialize_vars
      self.initialize_constraints
      self.initialize_objective
    end

    def solution
      self.prepare_problem
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
      
      self.cols.each {|c| c.set_bounds(Rglpk::GLP_DB, 0, 1)}
    end

    def initialize_constraints
      self.add_rows(self.students.length + self.timeslots.length)
      self.rows.each do |r|
        r.set_bounds(Rglpk::GLP_FX, 1, 1)
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

