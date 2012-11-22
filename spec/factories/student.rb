FactoryGirl.define do
  factory :student do |s|

    after(:create) do |student, evaluator|
      #Create preferences
      FactoryGirl.build_list(:preference, 5, :student => student)
      student.user = FactoryGirl.create(:user, {:owner_type => "Student", :owner_id => student.id, :owner => student})
      end
    end

end
