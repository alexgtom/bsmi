require 'spec_helper'

describe Student do
  it {should have_many :preferences}
  it {should have_many(:timeslots).through(:preferences)}
end
