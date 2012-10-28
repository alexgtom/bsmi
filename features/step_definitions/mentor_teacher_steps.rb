require 'time'

Given /^I am a mentor teacher$/ do
  #xxx LOGIN HERE
end

When /^I add the following timeslots on (.*?):$/ do |day ,table|
  day = day.downcase
  table.hashes.each do |timeslot|
    #TODO: make this less shitty
    #GAH
    extract_time("start_time", timeslot)
    extract_time("end_time", timeslot)

    within("##{day}") do
      timeslot.each_pair do |field, value|
        if not field.match(/timeslots/)
          field = "timeslots[][#{field}]"
        end
        #Special case classname for now 
        if field.to_s.include?("class_name")
          fill_in(field, :with => value)                    
        else
          select(value.to_s, :from => field)
        end        
      end
    end
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
