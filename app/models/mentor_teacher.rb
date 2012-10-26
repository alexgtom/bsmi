class MentorTeacher < ActiveRecord::Base
  attr_protected #none
  
  has_one :user, :as => :owner
  has_many :timeslots

end
