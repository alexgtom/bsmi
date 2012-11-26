require 'spec_helper'

describe "semesters/new" do
  before(:each) do
    assign(:semester, stub_model(Semester,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new semester form" do
  end
end
