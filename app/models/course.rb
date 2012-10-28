class Course < ActiveRecord::Base
  GRADE = ["K", "1", "2", "3", "4", "5", "6", "7", "8", HIGH_SCHOOL]

  validates_presence_of :name, :grade
  validates_inclusion_of :grade, :in => GRADE
  attr_protected #none
end
