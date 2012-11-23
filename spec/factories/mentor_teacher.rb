FactoryGirl.define do
  factory :mentor_teacher do
  
    # sequence :school do |n|
    #   school 'school#{n}'
    # end

    school
    
    after(:create) do |teacher| 
      if teacher.user.nil?
        teacher.user = FactoryGirl.create(:user, {:owner_type => "MentorTeacher", :owner_id => teacher.id})
      end
    end
#    association :user, :strategy => :build
    # user FactoryGirl.create(:user, :owner =>  #Generates a new user for this teacher
  end  

end
