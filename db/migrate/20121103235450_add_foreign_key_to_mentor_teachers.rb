class AddForeignKeyToMentorTeachers < ActiveRecord::Migration
  def change
    add_column :mentor_teachers, :school_id, :integer
  end
end
