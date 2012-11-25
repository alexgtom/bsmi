class Setting < ActiveRecord::Base
  attr_accessible :key, :value
  def self.defaults
    {
      'student_min_preferences' => 3, 
      'student_max_preferences' => 5,

      # for rspec test. dont delete.
      '!@#$' => 1  
    }
  end

  #set a setting value by [] notation
  def self.[]=(key, value)
    self.create!(:key => key, :value => value)
  end
  
  #retrieve the actual Setting record
  def self.[](key)
    if not self.find_by_key(key)
      if not self.defaults[key]
        return nil
      else
        return self.defaults[key].to_s
      end
    else
      return self.find_by_key(key).value.to_s
    end
  end
end
