class Deadline < ActiveRecord::Base
  attr_accessible :due_date, :summary, :title
end
