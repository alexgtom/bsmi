class Preference < ActiveRecord::Base
  attr_protected #none  
  belongs_to :student
  belongs_to :timeslot

  validates_uniqueness_of :student_id, :scope => [:timeslot_id]
end
