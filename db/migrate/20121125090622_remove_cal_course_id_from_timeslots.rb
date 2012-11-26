class RemoveCalCourseIdFromTimeslots < ActiveRecord::Migration
  def up
    remove_column :timeslots, :cal_course_id
  end

  def down
  end
end
