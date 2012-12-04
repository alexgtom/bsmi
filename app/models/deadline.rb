class Deadline < ActiveRecord::Base
  attr_protected #none
  attr_accessible :due_date, :summary, :title

  validates_presence_of :due_date, :summary, :title
end
