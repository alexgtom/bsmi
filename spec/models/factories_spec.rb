require 'spec_helper'

#Test all factories to make sure they work properly. 
#Code taken from https://github.com/thoughtbot/factory_girl/wiki/Testing-all-Factories-(with-RSpec)
describe 'validate FactoryGirl factories' do
 FactoryGirl.factories.each do |factory|
   context "with factory for :#{factory.name}" do
     subject { FactoryGirl.build(factory.name) }

     it "is valid" do
       #Hack to not test factories for building non activerecords
       unless not subject.respond_to?(:valid?)
         subject.valid?.should be, subject.errors.full_messages.to_s
       end
     end
   end
 end
end



# end
