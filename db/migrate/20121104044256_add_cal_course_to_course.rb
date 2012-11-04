class AddCalCourseToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :cal_course_id, :integer
  end
end
