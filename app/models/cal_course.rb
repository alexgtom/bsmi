class CalCourse < ActiveRecord::Base
  attr_accessible :course_grade, :name, :school_type, :timeslots
  #Associations
  has_many :course
  has_many :timeslots
  has_many :mentor_teacher, :through => :timeslots

  #Validations
  validates_associated :course, :message => "Must not be blank"
  attr_protected #none

  def build_timeslot_associations(times)
    if not times.nil?
      times.keys.each do |time_id|
        add_to = Timeslot.find_by_id(time_id)
        add_to.cal_course_id = self.id
        add_to.save!
      end
    end
  end

  def destroy_timeslot_associations
    self.timeslots.each do |timeslot|
      timeslot.cal_course_id = nil
      timeslot.save!
    end
  end

  def update_timeslot_associations(times)
    self.destroy_timeslot_associations()
    self.build_timeslot_associations(times)
  end

end
