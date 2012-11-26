require 'spec_helper'

describe "deadlines/index" do
  before(:each) do
    assign(:deadlines, [
      stub_model(Deadline,
        :title => "Title",
        :summary => "MyText"
      ),
      stub_model(Deadline,
        :title => "Title",
        :summary => "MyText"
      )
    ])
  end

  it "renders a list of deadlines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
