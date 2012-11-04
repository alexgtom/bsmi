class MentorTeacher < ActiveRecord::Base
  attr_accessible :name, :school
  attr_protected #none
  
  has_one :user, :as => :owner
  has_many :timeslots
  
  def get_name
    if not self.user.nil?
      self.user.name
    end
  end
end
