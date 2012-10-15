class Preference < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :timeslot

  validates_uniqueness_of :student_id, :scope => [:timeslot_id]
end
