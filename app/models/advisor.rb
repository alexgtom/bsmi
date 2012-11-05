class Advisor < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :user, :as => :owner
end
