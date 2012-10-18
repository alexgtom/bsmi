class Preference < ActiveRecord::Base
  attr_protected #none  
  belongs_to :student
  belongs_to :timeslot

  validates :ranking, :presence => true

  validates_uniqueness_of :student_id, :scope => [:timeslot_id]
  validates_uniqueness_of :student_id, :scope => [:ranking], :message => "The ranking must be unique for each preference" 
end
