class Timeslot < ActiveRecord::Base
  @@DAY = [:Sun, :Mon, :Tue, :Wed, :Thu, :Fri, :Sat]
  @@WEEK_DAYS = @@DAY - [:Sun, :Sat]
  def self.day_list
    @@DAY
  end

  def self.weekdays
    @@WEEK_DAYS
  end

  def self.day_index(value)
    @@DAY.index(value)
  end

  def day
    if not read_attribute(:day).nil?
      @@DAY[read_attribute(:day)]
    end
  end

  def day=(value)
    if value.class == String
      value = value.to_sym
    end
    write_attribute(:day, @@DAY.index(value))
  end

  def to_string
    return "#{self.day}|#{self.start_time.strftime("%I:%M%p")}|#{self.end_time.strftime("%I:%M%p")}"
  end
  
  def build_entry
    if self.mentor_teacher and school = School.find_by_name(self.mentor_teacher.school)
      entry = Hash.new
      entry["school_level"] = school.level
      entry["school_name"] = school.name
      entry["teacher"] = self.mentor_teacher.get_name
      entry["time"] = self.to_string
      entry["time_id"] = self.id
      return entry
    end
    return nil
  end

 
  attr_protected #none
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher
  belongs_to :course
  belongs_to :cal_course

  def selected?(student_id)
    Preference.where(["student_id = ?", student_id]).where(:timeslot_id => id).size > 0
  end
end
