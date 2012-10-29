require 'spec_helper'

describe "advisors/new" do
  before(:each) do
    assign(:advisor, stub_model(Advisor).as_new_record)
  end

  it "renders new advisor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advisors_path, :method => "post" do
    end
  end
end
