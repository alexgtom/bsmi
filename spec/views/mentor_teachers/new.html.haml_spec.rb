require 'spec_helper'

describe "mentor_teachers/new" do
  before(:each) do
    assign(:mentor_teacher, stub_model(MentorTeacher).as_new_record)
  end

  it "renders new mentor_teacher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mentor_teachers_path, :method => "post" do
    end
  end
end
