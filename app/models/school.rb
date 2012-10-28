class School < ActiveRecord::Base
  attr_protected #none

  LEVEL = ["High School", "Middle School", "Elementary School"]

  validates_presence_of :district
  validates_inclusion_of :level, :in => LEVEL
  belongs_to :district
end
