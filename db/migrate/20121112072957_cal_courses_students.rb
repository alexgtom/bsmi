class CalCoursesStudents < ActiveRecord::Migration
  def up
    create_table :cal_courses_students, :id => false do |t|
      t.integer :cal_course_id
      t.integer :student_id
    end
    add_index :cal_courses_students, [:cal_course_id, :student_id]
    add_index :cal_courses_students, [:student_id, :cal_course_id]
  end

  def down
    drop_table :students_timeslots
  end
end
