class Course < ActiveRecord::Base
  @@GRADE = [:K, 1, 2, 3, 4, 5, 6, 7, 8, :high_school]
  validates_inclusion_of :grade, :in => @@GRADE
  attr_accessible :grade, :name
end
