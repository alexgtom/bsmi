class CreateStudentsSemestersTable < ActiveRecord::Migration
  def up
    create_table :students_semesters, :id => false do |t|
        t.references :student
        t.references :semester
    end
    add_index :students_semesters, [:student_id, :semester_id]
    add_index :students_semesters, [:semester_id, :student_id]
  end

  def down
    drop_table :students_semesters
  end
end
