class CalCourse < ActiveRecord::Base
  attr_accessible :course_grade, :name, :school_type, :timeslots
  #Associations
  has_many :timeslots
  has_many :courses, :through => :timeslots
  has_many :mentor_teacher, :through => :timeslots
  has_and_belongs_to_many :students
  belongs_to :semester
  has_and_belongs_to_many :cal_faculties

  attr_protected #none

  def create_selection_for_new_course
    entries = []
    times = Timeslot.all
    if times
      times.each do |time|
        entries << time.build_entry(self.id)
      end
      entries.reject{|entry| entry == nil}
      entries.sort_by{|entry| entry["school_name"]}
    end
    return entries
  end

  def build_associations(times, cal_faculties)
    if not times.nil?
      times.keys.each do |time_id|
        add_to = Timeslot.find_by_id(time_id)
        add_to.cal_course = self
        add_to.save!
      end
    end
    cal_faculties.keys.each do |cal_faculty_id|
      add_to = CalFaculty.find(cal_faculty_id)
      add_to.cal_courses << self
      add_to.save!
    end
  end

  def destroy_associations
    self.timeslots.each do |timeslot|
      timeslot.cal_course = nil
      timeslot.save!
    end
    self.cal_faculties.each do |cal_faculty|
      cal_faculty.cal_courses.delete(self)
    end
  end

  def update_associations(times, cal_faculties)
    self.destroy_associations()
    self.build_associations(times, cal_faculties)
  end
end
