require 'spec_helper'

describe Student do
  it {should have_many :preferences}
  it {should have_and_belong_to_many :placements}
  it {should have_one :user }

end
