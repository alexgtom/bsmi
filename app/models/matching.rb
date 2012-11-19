require 'rglpk'
require 'set'


class Matching < ActiveRecord::Base
  attr_protected #none  
  belongs_to :student
  belongs_to :timeslot
  
end


class BipartiteGraph
  attr_accessor :adjacency_list

#Need ways of determining: duplicate node, dummy node
  class Node
    attr_reader :value, :type, :dup_num

    def initialize(value, type, options = {})
      @value = value
      @type = type
      @dummy = options[:dummy] || false
      @dup_num = options[:dup_num] || 0
    end

    def eql?(other)
      if not other.instance_of? Node
        return false
      else
        return (value == other.value and 
                type == other.type and          
                @dummy == other.dummy? and 
                @dup_num == other.dup_num)
      end
    end

    def ==(other)
      return self.eql?(other)
    end

    def hash
      return value.hash
    end

    def dummy?
      return @dummy
    end

    def duplicate?
      return @dup_num > 0
    end
  end

  class Edge
    attr_reader :student, :timeslot, :weight

    def initialize(student_node, timeslot_node, weight)
      @student = student_node
      @timeslot = timeslot_node
      @weight = weight
    end

    def hash
      return [@student, @timeslot].hash
    end

    def eql?(other)
      return (other.instance_of? Edge and
        other.student == self.student and
        other.timeslot == self.timeslot)
    end
  end
  
  attr_reader :num_edges
  def initialize(preferences=nil)
    self.adjacency_list = Hash.new {|hash, key| hash[key] = Hash.new}
    @sides = Hash[[[:student, Set.new], [:timeslot, Set.new]]]
    @sides.freeze
    @num_edges = 0
    @dummy_edges = Set.new
  end

  def edges
    Enumerator.new do |yielder|
      self.adjacency_list.each_pair do |student, timeslots|
        timeslots.each_pair do |t, weight|
          yielder << Edge.new(student, t, weight)
        end
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
    @num_edges += 1    
    self.adjacency_list[student_node][timeslot_node] = weight
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
  attr_reader :preferences, :graph
  def initialize(preferences, students, timeslots)
    @preferences = preferences
    @students = students
    @timeslots = timeslots
    @graph = BipartiteGraph.new
    
    @students.each do |s|
      @graph.add_node(s.id, :student)
    end
    @timeslots.each do |t|
      @graph.add_node(t.id, :timeslot)
    end

    @preferences.each do |p|
      @graph.add_edge(BipartiteGraph::Node.new(p.student_id, :student),
                      BipartiteGraph::Node.new(p.timeslot_id, :timeslot),
                      p.ranking
                      )
    end
  end

  def solve
    self.normalize_graph
    problem = MatchingProblem.new(self.graph)
    return extract_solution(problem.solution)
  end

  #Problem: not enough teachers for students
  #Solution: make dummy nodes for timeslots that can accomodate more


  #Goals
  #Equal numbers of teachers and students
  #Each timeslot duplicated up to max num students
  #Give everyone an edge to everything
  #If pick dummy edge for student, not actually matched
  def normalize_graph
    self.expand_timeslots
    self.graph.equalize_sides
    self.graph.connect        
  end

  #Split each timeslot into timeslot.max_num_assistant nodes, each of which can then
  #be matched separately
  def expand_timeslots
    timeslots_to_students = Hash.new {|hash, key| hash[key] = []}
    self.preferences.each do |p|
      timeslots_to_students[p.timeslot] << [p.student_id, p.ranking]
    end
    
    timeslots_to_students.each_pair do |timeslot, student_list|
      dup_nodes = (timeslot.max_num_assistants - 1).times.map do |i|
        self.graph.add_node(timeslot.id, :timeslot, :dup_num => i + 1)
      end
      
      dup_nodes.each do |dup_node|
        student_list.each do |student_id, ranking|        
          student_node = BipartiteGraph::Node.new(student_id, :student)
          self.graph.add_edge(student_node, dup_node, ranking)
        end
      end
    end
  end


  #Matchings = set of chosen edges
  #No dummies involved
  def extract_solution(matchings)
    matchings = matchings.reject do |m|
      m.student.dummy? or 
      m.timeslot.dummy? or 
      self.graph.dummy_edge?(m.student, m.timeslot)
    end

    return matchings.map do |m|
      Matching.create(:student_id => m.student.value,
                      :timeslot_id => m.timeslot.value,
                      :ranking => m.weight
                      )
    end
  end
  #Represents an assignment problem instance between mentor teacher timeslots
  #and students. 
  class MatchingProblem < Rglpk::Problem
    
    attr_reader :graph

    def initialize(graph)
      super()
      @graph = graph
    end
    
    def prepare_problem
      self.initialize_vars
      self.initialize_constraints
      self.initialize_objective
    end

    def solution
      self.prepare_problem
      self.simplex
      @solution = self.graph.edges.zip(self.cols).find_all{|e, col| col.get_prim > 0 }.
        map { |e, col| e }      
      return @solution
    end

    def initialize_objective
      self.obj.dir = Rglpk::GLP_MIN
      self.obj.coefs = self.graph.edges.map {|e| e.weight}
    end

    def initialize_vars 
      self.add_cols(self.graph.num_edges)
      self.cols.zip(self.graph.edges).each do |col, pref|
        col.name = "match_#{pref.student.value}_#{pref.timeslot.value}"
      end
      
      self.cols.each {|c| c.set_bounds(Rglpk::GLP_DB, 0, 1)}
    end

    def initialize_constraints
      self.add_rows(self.graph.students.length + self.graph.timeslots.length)
      self.rows.each do |r|
        r.set_bounds(Rglpk::GLP_FX, 1, 1)
      end      
      self.set_matrix(self.constraints_matrix.flatten)
    end
    
    #Provide the constraints matrix for the linear program. Each row in the matrix
    #corresponds either to a constraint on a timeslot or on a student.  
    def constraints_matrix    
      (self.graph.students.map {|s| constraints_row_for_student s} +
       self.graph.timeslots.map {|t| constraints_row_for_timeslot t})
    end

    def constraints_row_for_student(student_node)
      self.graph.edges.map do |e|
        if e.student == student_node
          1
        else
          0
        end
      end    
    end

    def constraints_row_for_timeslot(timeslot_node)
      self.graph.edges.map do |e|
        if e.timeslot == timeslot_node
          1
        else
          0
        end
      end    
    end
  end
end  

