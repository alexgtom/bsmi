class RemoveSchoolFromMentorTeachers < ActiveRecord::Migration
  def up
    remove_column :mentor_teachers, :school
  end

  def down
    add_column :mentor_teachers, :school, :string
  end
end
