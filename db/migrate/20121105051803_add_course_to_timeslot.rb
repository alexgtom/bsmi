class AddCourseToTimeslot < ActiveRecord::Migration
  def change
#    add_column :timeslots, :course_id, :string
    add_column :timeslots, :cal_course_id, :string
  end
end

