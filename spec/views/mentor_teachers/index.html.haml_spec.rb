require 'spec_helper'

describe "mentor_teachers/index" do
  before(:each) do
    assign(:mentor_teachers, [
      stub_model(MentorTeacher),
      stub_model(MentorTeacher)
    ])
  end

  it "renders a list of mentor_teachers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
