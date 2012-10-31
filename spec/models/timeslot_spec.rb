require 'spec_helper'

describe Timeslot do
  it 'should return the day_list' do
    Timeslot.day_list.should eq([:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday])
  end

  # it 'should return the symbol for the day of the timeslot' do
  #   t = Timeslot.new(:day => :tuesday)
  #   t.day.should eq(:tuesday)
  # end

  # it 'should be able to change the day of the timeslot' do
  #   t = Timeslot.new()
  #   t.day = :tuesday
  #   t.day.should eq(:tuesday)
  # end

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
    t = Timeslot.new()
    t.selected?(mock("id"))
  end

  it {should have_many :preferences}
  it {should have_many(:students).through(:preferences)}
  it {should belong_to :mentor_teacher}
  it {should validate_presence_of :start_time}
  it {should validate_presence_of :end_time}
  it {should validate_presence_of :day}


  describe :from_cal_event_json do

    def do_call
      Timeslot.from_cal_event_json(valid_params)
    end

    let(:valid_params) do
      JSON.dump(FactoryGirl.build(:cal_event_hash))
    end

    it "should return a valid Timeslot" do
      do_call.should be_valid
    end

    context "the event already exists" do

      before(:each) do
        @timeslot = FactoryGirl.create(:timeslot)
      end

      let(:valid_params) do
        JSON.dump(FactoryGirl.build(:cal_event_hash, 
                                    :db_id => @timeslot.id,
                                    :start => @timeslot.start_time + 3600
                                    ))
      end

      it "should find the appropriate event in the DB" do
        Timeslot.should_receive(:find).with(@timeslot.id)
        do_call
      end
    end
  end

  describe :time_in_week do
    it "should return a time in the week of Timeslot::WEEK_START" do
      time = Time.parse("10:00 AM")
      day = :monday
      res = Timeslot.time_in_week(time, day)
      res.year.should eq(Timeslot::WEEK_START.year)
      res.month.should eq(Timeslot::WEEK_START.month)
      res.wday.should eq(Timeslot::DAYS.index(day))
    end

  end
end
