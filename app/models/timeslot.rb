class Timeslot < ActiveRecord::Base
  attr_protected #none
  has_many :preferences
  has_many :students, :through => :preferences
  
end
