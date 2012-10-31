class CreateCalCourses < ActiveRecord::Migration
  def change
    create_table :cal_courses do |t|
      t.string :name
      t.text :timeslots
      t.string :school_type
      t.string :course_grade

      t.timestamps
    end
  end
end
