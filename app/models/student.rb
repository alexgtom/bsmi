class Student < ActiveRecord::Base  
  has_many :preferences
  has_many :mentor_teachers, :through => :placements

  has_one :user, :as => :owner
  has_and_belongs_to_many :placements, :uniq => true, :class_name => "Timeslot"
  accepts_nested_attributes_for :preferences
  has_and_belongs_to_many :cal_courses

  validate :cal_courses, :uniqueness => true
  validates_associated :preferences, :message => "must not be blank and the ranking number must be unique"

  def fix_ranking_gap
    # if a student has rankings [1, 2, 4] for their preferences, calling this function
    # will correct the rankings to [1, 2, 3]
    i = 1
    self.preferences.order("ranking asc").each do |p|
      logger.debug "#{i}"
      p.ranking = i
      p.save(:validate => false)
      i += 1
    end
  end
end
