class Student < ActiveRecord::Base  
  attr_protected #none
  has_many :preferences
  has_many :timeslots, :through => :preferences
  
end
