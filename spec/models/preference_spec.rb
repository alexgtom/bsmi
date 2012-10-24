require 'spec_helper'

describe Preference do
  it {should belong_to :student}
  it {should belong_to :timeslot}

  it {should validate_uniqueness_of(:ranking).scoped_to(:student_id)}
end
