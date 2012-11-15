class ChangeIdFormatInTimeslots < ActiveRecord::Migration
  def up
    remove_column :timeslots, :course_id
    remove_column :timeslots, :cal_course_id
    add_column :timeslots, :course_id, :integer
    add_column :timeslots, :cal_course_id, :integer
  end

  def down
    remove_column :timeslots, :course_id
    remove_column :timeslots, :cal_course_id
    add_column :timeslots, :course_id, :string
    add_column :timeslots, :cal_course_id, :string
  end
end
