class CreateStudentsSemestersTable < ActiveRecord::Migration
  def up
    create_table :semesters_students, :id => false do |t|
        t.references :student
        t.references :semester
    end
    add_index :semesters_students, [:student_id, :semester_id]
    add_index :semesters_students, [:semester_id, :student_id]
  end

  def down
    drop_table :semesters_students
  end
end
