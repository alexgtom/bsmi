class Preference < ActiveRecord::Base
  attr_protected #none  
  belongs_to :student
  belongs_to :timeslot
  has_one :semester, :through => :timeslot
  has_one :cal_course, :through => :timeslot

  #validates :ranking, :presence => true
  validates_uniqueness_of :ranking, :scope => [:student_id], :allow_null => true, :allow_blank => true

  validates :student_id, :presence => true
  validates :timeslot_id, :presence => true

  def self.find_by_semester_id(semester_id)
      self.select { |i| i.timeslot.cal_course.semester_id == semester_id }
  end

  def self.find_by_cal_course_id(cal_course_id)
      self.select { |i| i.timeslot.cal_course_id == cal_course_id }
  end

  def self.find_by_student_id_and_cal_course_id(student_id, cal_course_id)
      self.select { |i| i.timeslot.cal_course_id == cal_course_id and i.student_id == student_id }
  end
end
