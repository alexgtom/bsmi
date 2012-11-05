require 'spec_helper'

describe "advisors/edit" do
  before(:each) do
    @advisor = assign(:advisor, stub_model(Advisor))
  end

  it "renders the edit advisor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advisors_path(@advisor), :method => "post" do
    end
  end
end
