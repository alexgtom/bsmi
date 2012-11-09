require 'rglpk'

class MatchingSolver
  def initialize(preferences)
    self.preferences = preferences
    self.students = Hash.new
    self.timeslots = Hash.new
    t_index = s_index = 0
    preferences.each  do |p|
      if not self.students.include? p.student_id
        self.students[p.student_id] = s_index
        s_index += 1
      end
      if not self.timeslots.include? p.timeslot_id
        self.timeslots[p.timeslot_id] = t_index
        t_index += 1
      end
    end
  end

  def solve
    #TODO
  end
  attr_accessor :students, :timeslots

  #Provide the constraints matrix for the linear program. Each row in the matrix
  #corresponds either to a constraint on a timeslot or on a student.
  
  def constraints_matrix    
    if @constraints_matrix
      return @constraints_matrix
    end
    num_cols = self.variables.length
    student_constraints = (1..self.students.length * num_cols).map {0}
    timeslot_constraints = (1..self.timeslots.length * num_cols).map {0}
    
    self.preferences.each do |preference| 
      student_row_offset = self.students[preference.student_id] * num_cols      
      student_index = student_row_offset + self.var_index(student_id, timeslot_id)
      student_constraints[student_index] = 1

      timeslot_row_offset = self.timeslots[preference.timeslot_id] * num_cols      
      timeslot_index = timeslot_row_offset + self.var_index(student_id, timeslot_id)
      timeslot_constraints[timeslot_index] = 1
    end
    @constraints_matrix = student_constraints + timeslot_constraints
    return @constraints_matrix
  end

  #Map the combination of student_id and timeslot_id onto a column in the constraint
  #matrix
  def var_index(student_id, timeslot_id)
    self.timeslots[timeslot_id]*self.students.length + self.students[student_id]
  end
end   

# The same Brief Example as found in section 1.3 of 
# glpk-4.44/doc/glpk.pdf.
#
# maximize
#   z = 10 * x1 + 6 * x2 + 4 * x3
#
# subject to
#   p:      x1 +     x2 +     x3 <= 100
#   q: 10 * x1 + 4 * x2 + 5 * x3 <= 600
#   r:  2 * x1 + 2 * x2 + 6 * x3 <= 300
#
# where all variables are non-negative
#   x1 >= 0, x2 >= 0, x3 >= 0
#    
p = Rglpk::Problem.new
p.name = "sample"
p.obj.dir = Rglpk::GLP_MAX

rows = p.add_rows(3)
rows[0].name = "p"
rows[0].set_bounds(Rglpk::GLP_UP, 0, 100)
rows[1].name = "q"
rows[1].set_bounds(Rglpk::GLP_UP, 0, 600)
rows[2].name = "r"
rows[2].set_bounds(Rglpk::GLP_UP, 0, 300)

cols = p.add_cols(3)
cols[0].name = "x1"
cols[0].set_bounds(Rglpk::GLP_LO, 0.0, 0.0)
cols[1].name = "x2"
cols[1].set_bounds(Rglpk::GLP_LO, 0.0, 0.0)
cols[2].name = "x3"
cols[2].set_bounds(Rglpk::GLP_LO, 0.0, 0.0)

p.obj.coefs = [10, 6, 4]

p.set_matrix([
 1, 1, 1,
10, 4, 5,
 2, 2, 6
])

p.simplex
z = p.obj.get
x1 = cols[0].get_prim
x2 = cols[1].get_prim
x3 = cols[2].get_prim

printf("z = %g; x1 = %g; x2 = %g; x3 = %g\n", z, x1, x2, x3)
#=> z = 733.333; x1 = 33.3333; x2 = 66.6667; x3 = 0
