class Timeslot < ActiveRecord::Base
  @@DAY = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  def self.day_list
    @@DAY
  end

  def self.day_index(value)
    value = value.to_sym    # try to convert input value to symbol 
    @@DAY.index(value)
  end

  def day
    @@DAY[read_attribute(:day)]
  end

  def day=(value)
    value = value.to_sym    # try to convert input value to symbol 
    write_attribute(:day, @@DAY.index(value))
  end
  
  attr_protected #none
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher
  validates_inclusion_of :day, :in => @@DAY

  def selected?(student_id)
    Preference.where(["student_id = ?", student_id]).where(:timeslot_id => id).size > 0
  end
end
