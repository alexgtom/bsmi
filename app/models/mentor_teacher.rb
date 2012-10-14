class MentorTeacher < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :timeslot
attr_accessible :classesteaching, :email, :gradelevel, :mailingaddress, :password, :phonenumber, :school, :times
end
