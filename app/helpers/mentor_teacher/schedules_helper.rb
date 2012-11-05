module MentorTeacher::SchedulesHelper
  #Convert cal event hashes into javascript
  def dump_events(cal_events)
  
    cal_events.each do |e|
      monkey_patch_event(e)
    end    
    JSON.dump(cal_events)
  end

  def dump_event(cal_event)
    monkey_patch_event(cal_event)
    JSON.dump(cal_event)
  end

  def monkey_patch_event(event)
    #Monkey patch to_json for this event to return code for a javascript date object
    #This gives us a time in the local timezone.
    def monkey_patch_date_to_json(date)
      def date.to_json(arg)
        return "new Date(#{self.year}, #{self.month - 1}, #{self.day}, #{self.hour}, #{self.min})"
      end
    end
    monkey_patch_date_to_json(event['start'])
    monkey_patch_date_to_json(event['end'])      
  end
end
