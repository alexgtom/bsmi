class Semester < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :year
  has_and_belongs_to_many :cal_facultys
  has_and_belongs_to_many :mentor_teachers
  has_and_belongs_to_many :students
  has_many :cal_courses
  has_many :preferences, :through => :timeslots
  has_many :timeslots, :through => :cal_courses
  belongs_to :registration_deadline, :class_name => "Deadline"

  validates_length_of :year, :is => 4

  SEASON = ["Spring", "Summer", "Fall"]

  def <=>(other)
    result = self.year <=> other.year
    if result == 0
      result = Semester::SEASON.index(self.name) <=> Semester::SEASON.index(other.name)
    end
  end

  def description
    self.name + " " + self.year.to_s
  end

  def self.createSelection
    selection = []
    Semester.all.each do |semester|
      selection << semester.description
    end
    return selection
  end

  def self.getSemester(description)
    if description
      name, year = description.split
      semester = Semester.where(:year => year.to_i, :name => name)
      if semester.length > 0
        return semester[0]
      end
    end
  end
end
