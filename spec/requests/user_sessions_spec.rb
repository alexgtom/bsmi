require 'spec_helper'

describe "UserSessions" do
  describe "GET /user_sessions" do
    it "should redirect to signup page" do
      get user_sessions_path
      response.status.should be(404)
    end
  end
end
