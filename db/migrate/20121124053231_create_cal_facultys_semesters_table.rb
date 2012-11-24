class CreateCalFacultysSemestersTable < ActiveRecord::Migration
  def up
    create_table :calfacultys_semesters, :id => false do |t|
        t.references :cal_faculty
        t.references :semester
    end
    add_index :calfacultys_semesters, [:cal_faculty_id, :semester_id]
    add_index :calfacultys_semesters, [:semester_id, :cal_faculty_id]
  end

  def down
    drop_table :calfacultys_semesters
  end
end
