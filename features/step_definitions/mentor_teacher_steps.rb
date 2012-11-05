require 'time'

Given /^I am a mentor teacher$/ do
  password = "test"
  teacher = FactoryGirl.create(:mentor_teacher)
  user = FactoryGirl.create(:user,  
                            :password => password,
                            :owner => teacher
                            )             
  login(user.email, password)
end
include MentorTeacher::SchedulesHelper
When /^I add the following timeslots on (.*?):$/ do |day ,table|

  cal_events = table.hashes.map {|h| FactoryGirl.build(:cal_event_hash, h) }
  cal_events.each do |event_hash|
    event_hash = Hash[event_hash.each_pair.map {|k, v| [k.to_s, v]}]
    script = %Q{
var event = #{dump_event(event_hash)};
 eventNewCallback(event, null);
}

    page.execute_script(script)
    
    # within("#event_edit_container") do
    #   fill_in("Start time", :with => split_time(h["start_time"]))
    # end
    click_button('save')
  end
end
  

def extract_time(time_key, timeslot_hash)
  time = split_time(timeslot_hash[time_key])
  timeslot_hash["timeslots[][#{time_key}][hour]"] = time[:hour]
  timeslot_hash["timeslots[][#{time_key}][minute]"] = time[:minute]
  timeslot_hash.delete(time_key)
end
def split_time(time_str)
  time = Time.parse(time_str)
  {:hour => time.strftime("%I %p"), 
    :minute => time.min}
end


Then /^my schedule should look like:$/ do |table|
  
end
