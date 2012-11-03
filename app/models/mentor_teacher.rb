class MentorTeacher < ActiveRecord::Base
  attr_protected #none
  
  has_one :user, :as => :owner
  has_many :timeslots
  
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['name LIKE ?', search_condition])
  end
end
