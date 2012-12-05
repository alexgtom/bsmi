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

  def monkey_patch_event(cal_event)
    start_date = cal_event['start'] || cal_event[:start]

    unless start_date.nil?
      def start_date.to_json(*args) 
        return "new Date(#{self.year}, #{self.month - 1}, #{self.day}, #{self.hour}, #{self.min})"
      end
    end

    end_date = cal_event['end'] || cal_event[:end]

    unless end_date.nil?
      def end_date.to_json(*args) 
        return "new Date(#{self.year}, #{self.month - 1}, #{self.day}, #{self.hour}, #{self.min})"
      end
    end
  end
  
end
