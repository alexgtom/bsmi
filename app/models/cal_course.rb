class CalCourse < ActiveRecord::Base
  attr_accessible :course_grade, :name, :school_type, :timeslots
  #Associations
  has_many :course
  has_many :timeslot
  has_many :mentor_teacher, :through => :timeslot

  #Validations
  validates_associated :course, :message => "Must not be blank"
  attr_protected #none
end
