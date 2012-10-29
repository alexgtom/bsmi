require 'spec_helper'

describe "advisors/index" do
  before(:each) do
    assign(:advisors, [
      stub_model(Advisor),
      stub_model(Advisor)
    ])
  end

  it "renders a list of advisors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
