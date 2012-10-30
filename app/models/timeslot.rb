require 'time'
class Timeslot < ActiveRecord::Base

  #All times are relative to this week. This is hacky, but also essentially the
  #way Rails handles the time fields.
  CUR_YEAR = 2000
  CUR_MONTH = 1
  CUR_DAY = 3

  WEEK_START = Time.new(CUR_YEAR, CUR_MONTH, CUR_DAY)

  DAYS = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  WEEK_DAYS = DAYS - [:sunday, :saturday]

  attr_protected #none

  #Associations
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher

  #Validations
  validates :day, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true

  def self.day_list
    DAYS
  end

  def self.weekdays
    WEEK_DAYS
  end

  def self.day_index(value)
    DAYS.index(value)
  end

  def day
    index = read_attribute(:day)
    DAYS[index] unless index.nil?
  end

  def day=(value)
    write_attribute(:day, DAYS.index(value))
  end  

  def self.from_cal_event_json(json_str)
    event = JSON.parse(json_str)

    start_time = Time.parse(event["start"])
    end_time = Time.parse(event["end"])

    self.create!(:class_name => event["title"], 
                 :start_time => start_time,
                 :end_time => end_time,
                 :day => DAYS[start_time.wday],
                 :num_assistants => event["num_assistants"]
                 )

  end

  #Return a time on the given day in the week of Timeslot::WEEK_START
  def self.time_in_week(time_obj, day) 
      Time.new(Timeslot::WEEK_START.year,
               Timeslot::WEEK_START.month,
               Timeslot::WEEK_START.day + Timeslot::WEEK_DAYS.index(day),
               time_obj.hour,
               time_obj.min
               )
  end

  #Convert this timeslot into something understood by the front end
  def to_cal_event_hash
    def to_js_time(time, day)
      Timeslot.time_in_week(time, day).utc.iso8601
    end

    { 'id' => self.id,
      'start' => to_js_time(self.start_time, self.day),
      'end' => to_js_time(self.end_time, self.day),
      'title' => self.class_name,
      'num_assistants' => self.num_assistants
    }
  end
  
  def selected?(student_id)
    Preference.where(["student_id = ?", student_id]).where(:timeslot_id => id).size > 0
  end



  
end
