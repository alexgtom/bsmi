class MentorTeacher < ActiveRecord::Base
  attr_accessible :name
  attr_protected #none
  
  has_one :user, {:as => :owner, :dependent => :destroy}
  has_many :timeslots, :uniq => true
  has_many :students, :through => :timeslots
  has_and_belongs_to_many :semesters, :uniq => true

  accepts_nested_attributes_for :timeslots, :allow_destroy => true
  accepts_nested_attributes_for :user, :allow_destroy => true

  belongs_to :school
  
  def build_entry
      entry = Hash.new 
    if self.school
      entry["school_level"] = self.school.level
      entry["school_name"] = self.school.name
    else
      entry["school_level"] = nil
      entry["school_name"] = nil
    end
    entry["teacher"] = self.user.name
    return entry
  end

  def timeslots_for_semester(semester_id)
    Timeslot.joins(:cal_course, :mentor_teacher).
      where('cal_courses.semester_id' => semester_id,
            'mentor_teachers.id' => self.id)
  end
end
