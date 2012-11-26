class Course < ActiveRecord::Base
  has_many :timeslots
  has_many :mentor_teachers, :through => :timeslots

  GRADE = ["K", "1", "2", "3", "4", "5", "6", "7", "8", HIGH_SCHOOL]
  
  validates_presence_of :name, :grade
  attr_protected #none
end
