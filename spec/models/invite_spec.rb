require 'spec_helper'

describe Invite do

  def valid_attributes
    {:email => 'myemail', :invite_code => 'whatevercodeishere', :first_name => 'firstname', :last_name => 'lastname', :owner_type => 'myowner'}
  end

  describe "redeemed!" do
    it "should working" do
      invite = Invite.create! valid_attributes
      @result = invite.redeemed!
      @result.should eq(true)
    end
  end
end
