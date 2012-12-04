require 'matching'
class CalCourse < ActiveRecord::Base
  attr_accessible :name, :school_type, :timeslots
  #Associations
  has_many :timeslots
  has_many :courses, :through => :timeslots
  has_many :mentor_teacher, :through => :timeslots
  has_and_belongs_to_many :students
  belongs_to :semester

  attr_protected #none

  validates_presence_of :semester, :name

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

  def build_timeslot_associations(times)
    if not times.nil?
      times.keys.each do |time_id|
        add_to = Timeslot.find_by_id(time_id)
        add_to.cal_course = self
        add_to.save!
      end
    end
  end

  def destroy_timeslot_associations
    self.timeslots.each do |timeslot|
      timeslot.cal_course = nil
      timeslot.save!
    end
  end

  def update_timeslot_associations(times)
    self.destroy_timeslot_associations()
    self.build_timeslot_associations(times)
  end

  #Perform matchings for students in this Cal course.  
  def match 
#User.where(:id => accounts.project(:user_id).where(accounts[:user_id].not_eq(6)))
    preferences = Preference.where(:student_id => self.students.select(:id),
                                   :timeslot_id => self.timeslots.select(:id))
    solver = Matching::MatchingSolver.new(preferences, self.students, self.timeslots)

    solution = solver.solve

    solution.each do |match|
      Student.find(match[:student_id]).placements << Timeslot.find(match[:timeslot_id])
    end
  end

  
  def self.match_all 
    self.all.each {|course| course.match}
  end

end
