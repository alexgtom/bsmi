class District < ActiveRecord::Base
  attr_protected #none
  has_many :school
end
