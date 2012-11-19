class CreateCalCoursesCalFaculties < ActiveRecord::Migration
  def up
    create_table :cal_courses_cal_faculties, :id => false do |t|
      t.integer :cal_course_id
      t.integer :cal_faculty_id
    end
    #add_index :cal_courses_cal_faculties, [:cal_course_id, :cal_faculty_id]
    #add_index :cal_courses_cal_faculties, [:cal_faculty_id, :cal_course_id]
  end

  def down
    drop_table :cal_courses_cal_faculties
  end
end
