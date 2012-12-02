class District < ActiveRecord::Base
  attr_protected #none
  validates_presence_of :name
  has_many :schools, :uniq => true
end
