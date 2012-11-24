class CreateMentorTeachersSemestersTable < ActiveRecord::Migration
  def up
    create_table :mentor_teachers_semesters, :id => false do |t|
        t.references :mentor_teacher
        t.references :semester
    end
    add_index :mentor_teachers_semesters, [:mentor_teacher_id, :semester_id], :name => 'index_mt_s'
    add_index :mentor_teachers_semesters, [:semester_id, :mentor_teacher_id], :name => 'inded_s_mt'
  end

  def down
    drop_table :mentor_teachers_semesters
  end
end
