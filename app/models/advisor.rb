class Advisor < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['name LIKE ?', search_condition])
  end
end
