class Semester < ActiveRecord::Base
  PUBLIC = "Public"
  PRIVATE = "Private"
  FALL = "Fall"
  SPRING = "Spring"
  SUMMER = "Summer"

  SEASONS = [FALL, SPRING, SUMMER]
  STATUSES = [PUBLIC, PRIVATE]

  attr_protected #none
  has_and_belongs_to_many :cal_facultys
  has_and_belongs_to_many :mentor_teachers
  has_and_belongs_to_many :students
  has_many :cal_courses
  has_many :preferences, :through => :timeslots
  has_many :timeslots, :through => :cal_courses
  belongs_to :registration_deadline, :class_name => "Deadline"

  validates_length_of :year, :is => 4

  validates_inclusion_of :name, :in => SEASONS
  validates_inclusion_of :status, :in => STATUSES
end
