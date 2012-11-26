require 'spec_helper'

describe "semesters/edit" do
  before(:each) do
    @semester = assign(:semester, stub_model(Semester,
      :name => "MyString"
    ))
  end

  it "renders the edit semester form" do
  end
end
