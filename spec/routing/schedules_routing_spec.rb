require_relative "../spec_helper"

describe "mentor_teacher_schedules route" do
  #Route is resourceful, so this should be enough for now...
 it "should route properly" do
    expect(:get => "/mentor_teacher/schedule").to route_to("mentor_teacher/schedules#show")
                                                         
 end
end



