class School < ActiveRecord::Base
  attr_protected #none

  LEVEL = [HIGH_SCHOOL, MIDDLE_SCHOOL, ELEMENTARY_SCHOOL]

  validates_presence_of :district, :name, :level
  validates_inclusion_of :level, :in => LEVEL
  belongs_to :district
  has_many :mentor_teachers, :uniq => true
  has_many :students, :through => :mentor_teachers
end
