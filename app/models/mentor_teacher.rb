class MentorTeacher < ActiveRecord::Base
  attr_protected #none
  has_many :timeslots

end
