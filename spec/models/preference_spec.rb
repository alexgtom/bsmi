require 'spec_helper'

describe Preference do
  it {should belong_to :student}
  it {should belong_to :timeslot}

  it {should validate_uniqueness_of(:student_id).scoped_to(:timeslot_id)}
end
