require 'spec_helper'

describe "students/index" do
  before(:each) do
    assign(:students, [
      stub_model(Student),
      stub_model(Student)
    ])
  end
end
