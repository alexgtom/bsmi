class Timeslot < ActiveRecord::Base
  has_many :preferences
  has_many :students, :through => :preferences
  belongs_to :mentor_teacher
end
