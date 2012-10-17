class Timeslot < ActiveRecord::Base
  DAY = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  def self.day_index(value)
    DAY.index(value)
  end

  def day
    DAY[read_attribute(:day)]
  end

  def day=(value)
    write_attribute(:day, DAY.index(value))
  end
  
  attr_protected #none
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher
end
