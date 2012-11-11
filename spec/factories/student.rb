FactoryGirl.define do
  factory :student do |s|

    after(:create) do |student, evaluator|
      #Create preferences
      FactoryGirl.build_list(:preference, 5, :student => student)
    end

  end
end
