require 'spec_helper'

describe CalCourse do

before(:each) do
    @course1 = mock(:course)
    @course2 = mock(:course)
    @timeslot1 = mock(:timeslot)

    @course1.should_receive(:timeslots).and_return([@timeslot1])
    Course.stub(:find).with(:all) { [@course1, @course2] }
    @user.save!

    company = create(:acme)
    course = build(:acme_company, :company => company)
    course.save!

  @practice = create(:practice, :user_id => @user.id, :topic => "Factors and Multiples" )
end

  before(:each) do
    @person = mock("person")
    # Generally, prefer stub! over should_receive in setup.
    @person.stub!(:new_record?).and_return(false)
    Person.stub!(:new).and_return(@person)
  end
  it "should create a new, unsaved person on GET to create" do
    # Using should_receive here overrides the stub in setup. Even
    # though it is the same as the stub, using should_receive sets
    # an expectation that  will be verified. It also helps to
    # better express the intent of this example.
    Person.should_receive(:new).and_return(@person)
    get 'create'
  end




describe User do
  it 'should add specified points to a user' do
    lambda { subject.add_points(100) }.should change { subject.points }.by(100)
  end
end


    describe :create_selection_for_new_course do
    it "should return all timeslots in form of entries" do
      @fake_results = [mock('Course'), mock('Course')]
      Course.should_receive(:all).and_return(@fake_results)
    end

  end
end



  def create_selection_for_new_course
    entries = Array.new
    courses = Course.all
    if courses
      debugger
      courses.each do |course|
        times = course.timeslots
        if not times.nil?
          times.each do |time| 
            tim = nil
            if entry = time.build_entry 
              entry["course"] = course
            end
            entries << entry
          end
        end
      end
    end
    return entries
  end
