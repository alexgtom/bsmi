class Course < ActiveRecord::Base
  GRADE = %w( K 1 2 3 4 5 6 7 8 high_school )
  has_many :timeslots
  has_many :mentor_teacher, :through => :timeslots
  validates_inclusion_of :grade, :in => GRADE

  attr_protected #none
end
