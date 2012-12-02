class CalFaculty < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :user, :as => :owner
  has_and_belongs_to_many :cal_courses, :uniq => true
  has_many :students, :through => :cal_courses, :uniq => true
  has_and_belongs_to_many :semesters, :uniq => true
end
