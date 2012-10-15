require 'spec_helper'

describe Timeslot do
  it {should have_many :preferences}
  it {should have_many(:students).through(:preferences)}
  
  it {should belong_to :mentor_teacher}
end
