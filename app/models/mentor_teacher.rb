class MentorTeacher < ActiveRecord::Base
  attr_accessible :name
  attr_protected #none
  
  has_one :user, :as => :owner
  has_many :timeslots, :uniq => true
  has_many :students, :through => :timeslots
  has_and_belongs_to_many :semesters, :uniq => true

  belongs_to :school
  
  def build_entry
    if self.school
      entry = Hash.new 
      entry["school_level"] = self.school.level
      entry["school_name"] = self.school.name
      entry["teacher"] = self.user.name
      return entry
    end
  end
end
