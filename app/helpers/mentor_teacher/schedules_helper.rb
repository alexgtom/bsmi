module MentorTeacher::SchedulesHelper
  #Convert cal event hashes into javascript
  def dump_events(cal_events)
    #Monkey patch to_json for this event to return code for a javascript date object
    #This gives us a time in the local timezone.
    def monkey_patch_date_to_json(date)
      def date.to_json(arg)
        return "new Date(#{self.year}, #{self.month - 1}, #{self.day}, #{self.hour}, #{self.min})"
      end
    end
    cal_events.each do |e|
      monkey_patch_date_to_json(e['start'])
      monkey_patch_date_to_json(e['end'])      
    end
    
    JSON.dump(cal_events)
  end
end
