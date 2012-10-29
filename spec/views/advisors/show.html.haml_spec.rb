require 'spec_helper'

describe "advisors/show" do
  before(:each) do
    @advisor = assign(:advisor, stub_model(Advisor))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
