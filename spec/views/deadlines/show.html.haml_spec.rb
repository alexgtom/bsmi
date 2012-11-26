require 'spec_helper'

describe "deadlines/show" do
  before(:each) do
    @deadline = assign(:deadline, stub_model(Deadline,
      :title => "Title",
      :summary => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
