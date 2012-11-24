class Semester < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :year
  has_and_belongs_to_many :cal_facultys
  has_and_belongs_to_many :mentor_teachers
  has_and_belongs_to_many :students
  has_many :cal_courses
  has_many :preferences, :through => :timeslots
  has_many :timeslots

  validates_length_of :year, :is => 4

  SEASON = ["Fall", "Spring", "Summer"]
end
