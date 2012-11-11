require 'spec_helper'

#Test all factories to make sure they work properly. 
#Code taken from https://github.com/thoughtbot/factory_girl/wiki/Testing-all-Factories-(with-RSpec)
describe 'validate FactoryGirl factories' do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { FactoryGirl.build(factory.name) }

      it "is valid" do
        subject.valid?.should be, subject.errors.full_messages
      end
    end
  end
end



# end
