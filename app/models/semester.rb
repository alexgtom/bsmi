class Semester < ActiveRecord::Base
  attr_protected #none
  has_and_belongs_to_many :cal_facultys
  has_and_belongs_to_many :mentor_teachers
  has_and_belongs_to_many :students
  has_many :cal_courses
  has_many :preferences, :through => :timeslots
  has_many :timeslots, :through => :cal_courses
  belongs_to :registration_deadline, :class_name => "Deadline"

  validates_length_of :year, :is => 4

  SEASON = ["Fall", "Spring", "Summer"]
end
