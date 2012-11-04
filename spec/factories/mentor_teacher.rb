FactoryGirl.define do
  factory :mentor_teacher do
  
    sequence :school do |n|
      school 'school#{n}'
    end

    after(:create) do |teacher| 
      teacher.user.save
    end
    association :user, :strategy => :build
    # user FactoryGirl.create(:user, :owner =>  #Generates a new user for this teacher
  end  

end
