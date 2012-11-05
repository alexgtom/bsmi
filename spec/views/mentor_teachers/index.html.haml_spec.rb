require 'spec_helper'

describe "mentor_teachers/index" do
  before(:each) do
    assign(:mentor_teachers, [
      stub_model(MentorTeacher),
      stub_model(MentorTeacher)
    ])
  end

end
