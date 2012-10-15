class MentorTeacher < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :timeslots
  attr_accessible :classesteaching, :email, :gradelevel, :mailingaddress, :password, :phonenumber, :school
end
