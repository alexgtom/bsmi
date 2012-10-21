require 'spec_helper'

describe Timeslot do
  it 'should return the day_list' do
    Timeslot.day_list.should eq([:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday])
  end

  it 'should return the symbol for the day of the timeslot' do
    t = Timeslot.new(:day => :tuesday)
    t.day.should eq(:tuesday)
  end

  it 'should be able to change the day of the timeslot' do
    t = Timeslot.new()
    t.day = :tuesday
    t.day.should eq(:tuesday)
  end

  it 'should return the index of the day given the symbol for the day' do
    Timeslot.day_index(:sunday).should eq(0)
    Timeslot.day_index(:monday).should eq(1)
    Timeslot.day_index(:tuesday).should eq(2)
    Timeslot.day_index(:wednesday).should eq(3)
    Timeslot.day_index(:thursday).should eq(4)
    Timeslot.day_index(:friday).should eq(5)
    Timeslot.day_index(:saturday).should eq(6)
  end

  it 'has a selected method that returns true if it the timeslot has been selected' do
  end

  it {should have_many :preferences}
  it {should have_many(:students).through(:preferences)}
  it {should belong_to :mentor_teacher}
end
