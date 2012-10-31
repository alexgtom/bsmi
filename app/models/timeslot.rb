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
    @@DAY[read_attribute(:day)]
  end

  def day=(value)
    write_attribute(:day, @@DAY.index(value))
  end  

  def to_string
    %w"#{:day} #{:start_time} #{end_time}"
  end
  
  
  attr_protected #none
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher

  def selected?(student_id)
    Preference.where(["student_id = ?", student_id]).where(:timeslot_id => id).size > 0
  end
end
