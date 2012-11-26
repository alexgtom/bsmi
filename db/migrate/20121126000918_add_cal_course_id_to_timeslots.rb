class AddCalCourseIdToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :cal_course_id, :integer
  end
end
