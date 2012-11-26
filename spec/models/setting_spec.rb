require 'spec_helper'

describe Setting do
  it "should return the current value if set" do
    Setting['a'] = 1
    Setting['a'].should eq("1")
  end

  it "should return nil if value is not in default or in database"  do
    Setting['a'].should eq(nil)
  end

  it "should return the default value if not in the database" do
    Setting['!@#$'].should eq("1")
  end

  it "should return the database value even if there is a default value" do
    Setting['!@#$'] = 2
    Setting['!@#$'].should eq("2")
  end

  it "should update the same instance of a setting if it already exists" do
    Setting['a'] = 1
    Setting['a'].should eq("1")
    Setting['a'] = 2
    Setting['a'].should eq("2")
  end
end
