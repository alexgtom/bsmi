class School < ActiveRecord::Base
  attr_protected #none

  LEVEL = [HIGH_SCHOOL, MIDDLE_SCHOOL, ELEMENTARY_SCHOOL]

  validates_presence_of :district, :name, :level
  validates_inclusion_of :level, :in => LEVEL
  belongs_to :district
end
