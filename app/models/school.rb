class School < ActiveRecord::Base
  @@LEVEL = [:high, :middle, :elementary]
  attr_accessible :name

  def self.level_list
    @@DAY
  end

  def self.level_index(value)
    @@DAY.index(value)
  end

  def level
    @@LEVEL[read_attribute(:day)]
  end

  def level=(value)
    write_attribute(:level, @@level.index(value))
  end

  belongs_to :district
end
