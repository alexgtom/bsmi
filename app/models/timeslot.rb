class Timeslot < ActiveRecord::Base
  @@DAY = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  @@WEEK_DAYS = @@DAY - [:sunday, :saturday]
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
    @@DAY[read_attribute(:day)]
  end

  def day=(value)
    write_attribute(:day, @@DAY.index(value))
  end  

  def self.from_cal_event_json(json_str)
    event = JSON.parse(json_str)
    self.new(:class_name => event["title"], 
             :start_time => Time.parse(event["start"]),
             :end_time => Time.parse(event["end"]))    
  end
  
  attr_protected #none
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher

  def selected?(student_id)
    Preference.where(["student_id = ?", student_id]).where(:timeslot_id => id).size > 0
  end
end
