require 'matching'
class CalCourse < ActiveRecord::Base
  attr_accessible :name, :school_type, :timeslots
  #Associations
  has_many :timeslots
  has_many :courses, :through => :timeslots
  has_many :mentor_teacher, :through => :timeslots
  has_many :matchings, :through => :students
  has_and_belongs_to_many :students
  belongs_to :semester
  has_and_belongs_to_many :cal_faculties

  attr_protected #none

  validates_presence_of :semester, :name
  validates_uniqueness_of :name

  def create_selection_for_new_course
    entries = []
    times = Timeslot.all.delete_if{|x| x.cal_course_id != nil and x.cal_course_id != self.id }
    if times
      times.each do |time|
        entries << time.build_entry(self.id)
      end
      entries.reject{|entry| entry == nil}
      entries.sort_by{|entry| entry["school_name"]}
    end
    return entries
  end

  def build_associations(times, cal_faculty)
    self.timeslots = []
    times.each do |id|
      self.timeslots << Timeslot.find(id)
    end
=begin
    if not times.nil?
      times.keys.each do |time_id|
        add_to = Timeslot.find_by_id(time_id)
        add_to.cal_course = self
        add_to.save!
      end
    end
    if cal_faculty
      cal_faculty.keys.each do |cal_faculty_id|
        add_to = CalFaculty.find(cal_faculty_id)
        if not add_to.cal_courses.include?(self)
          add_to.cal_courses << self
        end
        add_to.save!
      end
    end
=end
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


  #Perform matchings for students in this Cal course.  
  def match 
#User.where(:id => accounts.project(:user_id).where(accounts[:user_id].not_eq(6)))
    preferences = Preference.where(:student_id => self.students.select(:id),
                                   :timeslot_id => self.timeslots.select(:id))
    solver = MatchingBackend::MatchingSolver.new(preferences, self.students, self.timeslots)

    solution = solver.solve

    solution.each do |match|
      Matching.create(match)      
    end
  end

  def self.current_semester_courses
    self.joins(:semester).where('semesters.id = ?', Semester.current_semester.id)
  end
  
  def self.match_all 
    self.current_semester_courses.each do |course|
      course.match
    end
    cur_semester = Semester.current_semester
    cur_semester.matchings_performed = true
    cur_semester.save       
  end

end
