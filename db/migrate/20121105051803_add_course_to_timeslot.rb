class AddCourseToTimeslot < ActiveRecord::Migration
  def change
# <<<<<<< HEAD
    add_column :timeslots, :course_id, :string
# =======
# #    add_column :timeslots, :course_id, :string
# >>>>>>> mentor_teacher_test
    add_column :timeslots, :cal_course_id, :string
  end
end

