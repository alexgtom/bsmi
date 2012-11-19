require 'spec_helper'

shared_examples_for "a factory" do
  subject { FactoryGirl.build(factory) }

  it "is valid" do
    subject.valid?.should be, subject.errors.full_messages
  end
end


