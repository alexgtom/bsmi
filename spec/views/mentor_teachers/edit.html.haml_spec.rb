require 'spec_helper'

describe "mentor_teachers/edit" do
  before(:each) do
    @mentor_teacher = assign(:mentor_teacher, stub_model(MentorTeacher))
  end

  it "renders the edit mentor_teacher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mentor_teachers_path(@mentor_teacher), :method => "post" do
    end
  end
end
