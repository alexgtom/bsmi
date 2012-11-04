class Course < ActiveRecord::Base
  has_many :timeslots
  has_many :mentor_teacher, :through => :timeslots

  belongs_to :cal_course

  GRADE = ["K", "1", "2", "3", "4", "5", "6", "7", "8", HIGH_SCHOOL]
  
  has_many :timeslots
  validates_presence_of :name, :grade
  attr_protected #none
end
