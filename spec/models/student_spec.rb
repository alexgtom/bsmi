require 'spec_helper'

describe Student do
  it {should have_many :preferences}
  it {should have_many :placements}
  it {should have_many :matchings}
  it {should have_one :user }

end
