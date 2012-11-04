class Preference < ActiveRecord::Base
  attr_protected #none  
  belongs_to :student
  belongs_to :timeslot

  #validates :ranking, :presence => true
  validates :timeslot, :presence => true
  
  validates_uniqueness_of :ranking, :scope => [:student_id], :allow_nul => true, :allow_blank => true

end
