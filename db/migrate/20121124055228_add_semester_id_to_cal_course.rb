class AddSemesterIdToCalCourse < ActiveRecord::Migration
  def change
    add_column :cal_courses, :semester_id, :integer
  end
end
