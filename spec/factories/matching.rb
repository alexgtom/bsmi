FactoryGirl.define do
  factory :matching do |p|
    sequence(:ranking) do |i|
      i % 10
    end
    
    timeslot
    student
    # association :timeslot, :factory => :timeslot
    # association :student, :factory => :student
  end
end
