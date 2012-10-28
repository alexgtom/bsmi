class Timeslot < ActiveRecord::Base
  attr_protected #none

  #Associations
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher

  #Validations
  validates :day, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true

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
    index = read_attribute(:day)
    @@DAY[index] unless index.nil?
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

  #Convert this timeslot into something understood by the front end
  def to_cal_event_hash
    time_format = '%Y/%m/%d %H:%M:%S %z'
    { 'id' => self.id,
      'start' => 'new Date(#{self.start_time.strftime(time_format)})',
      'end' => 'new Date(#{self.end_time.strftime(time_format)})',
      'title' => self.class_name
    }
  end
  
  def selected?(student_id)
    Preference.where(["student_id = ?", student_id]).where(:timeslot_id => id).size > 0
  end



  
end
