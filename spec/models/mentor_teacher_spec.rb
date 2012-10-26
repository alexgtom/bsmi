require 'spec_helper'

describe MentorTeacher do
  it {should have_many :timeslots}
  it {should have_one(:user)}
end
