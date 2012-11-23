FactoryGirl.define do
  factory :cal_faculty do
  
    # sequence :school do |n|
    #   school 'school#{n}'
    # end

    after(:create) do |cal_faculty| 
      if cal_faculty.user.nil?
        cal_faculty.user = FactoryGirl.create(:user, { 
            :owner_type => "CalFaculty", 
            :owner_id => cal_faculty.id,
            :first_name => "FirstName",
            :last_name => "LastName",
          }
        )
      end
    end
#    association :user, :strategy => :build
    # user FactoryGirl.create(:user, :owner =>  #Generates a new user for this teacher
  end  

end
