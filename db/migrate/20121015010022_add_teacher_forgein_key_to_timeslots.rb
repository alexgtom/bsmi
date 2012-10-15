class AddTeacherForgeinKeyToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :mentor_teacher_id, :integer
  end
end
