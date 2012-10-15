# Remove columns from mentor_teachers that will be handled by assoications
class RemoveExtraneousColumnsFromMentorTeacher < ActiveRecord::Migration
  def up
    remove_column :mentor_teachers, :classesteaching
    remove_column :mentor_teachers, :gradelevel
  end

  def down
    add_column :mentor_teachers, :classesteaching, :string 
    add_column :mentor_teachers, :gradelevel, :string 
  end
end
