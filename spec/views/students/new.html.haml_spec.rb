require 'spec_helper'

describe "students/new" do
  before(:each) do
    assign(:student, stub_model(Student).as_new_record)
  end

  it "renders new student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => students_path, :method => "post" do
    end
  end
end
