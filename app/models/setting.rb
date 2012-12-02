class Setting < ActiveRecord::Base
  attr_accessible :key, :value
  validates_uniqueness_of :key


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
    key = key.to_s
    value = value.to_s
    
    pair = self.find_by_key(key)
    if pair
      pair.value = value
      pair.save!
    else
      self.create!(:key => key, :value => value)
    end
  end
  
  #retrieve the actual Setting record
  def self.[](key)
    if not self.find_by_key(key)
      if not self.defaults[key]
        return nil
      else
        default = self.defaults[key].to_s
        return Integer(default) rescue default
      end
    else
      value = self.find_by_key(key).value.to_s
      return Integer(value) rescue value
    end
  end
end
