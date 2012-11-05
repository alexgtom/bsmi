require 'spec_helper'

describe "mentor_teachers/show" do
  before(:each) do
    @mentor_teacher = assign(:mentor_teacher, stub_model(MentorTeacher))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
